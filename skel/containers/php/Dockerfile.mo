FROM php:{{PROJECT_PHP_VERSION}}
MAINTAINER David Parrish <daveparrish@tutanota.com>

# Update Debian (so additional software can be installed with apt-get)
RUN apt-get -y update

# Install required PHP extensions.
# gd
RUN apt-get -y --no-install-recommends install libgd-dev libjpeg62-turbo-dev && \
docker-php-ext-configure gd --with-jpeg-dir=/usr/include && \
docker-php-ext-install gd
# MySQL
RUN docker-php-ext-install mysql
# mbstring
RUN docker-php-ext-configure mbstring --enable-mbstring && \
docker-php-ext-install mbstring
# pcntl (required by drush 7.x)
RUN docker-php-ext-install pcntl
# zip (required by drush 7.x)
RUN docker-php-ext-install zip

# Install msmtp
RUN apt-get -y --no-install-recommends install msmtp

# Install mariadb client (required for 'drush sqlc')
RUN apt-get -y --no-install-recommends install mariadb-client

# http://docs.drush.org/en/master/install/
# Install Composer for installing Drush
RUN curl -sS https://getcomposer.org/installer | php && \
mv composer.phar /usr/local/bin/composer && \
ln -s /usr/local/bin/composer /usr/bin/composer

# Install Drush (latest)
RUN apt-get -y --no-install-recommends install git && \
git clone https://github.com/drush-ops/drush.git /usr/local/src/drush && \
cd /usr/local/src/drush && \
git checkout 7.x && \
ln -s /usr/local/src/drush/drush /usr/bin/drush && \
composer install

# Clean up apt
RUN apt-get clean && \
rm -r /var/lib/apt/lists/*

# Use the default php.ini depending on $environment.
RUN cp /usr/src/php/php.ini-{{PROJECT_ENVIRONMENT}} /usr/local/etc/php/php.ini

# Add msmtp settings
COPY msmtp/msmtp_php /etc/msmtp_php
RUN chown www-data:www-data /etc/msmtp_php && \
sed -i 's|;sendmail_path =$|sendmail_path = "{{PROJECT_SENDMAIL_PATH}}"|g' /usr/local/etc/php/php.ini

# Set working directory
WORKDIR /srv/http/source
