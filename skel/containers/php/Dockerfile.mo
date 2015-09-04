FROM php:{{PROJECT_PHP_VERSION}}
MAINTAINER David Parrish <daveparrish@tutanota.com>

# Update Debian (so additional software can be installed with apt-get)
RUN apt-get -y update #&& \
##apt-get -y upgrade

# Install required PHP extensions.
# gd
RUN apt-get -y --no-install-recommends install libgd-dev libjpeg62-turbo-dev && \
docker-php-ext-configure gd --with-jpeg-dir=/usr/include && \
docker-php-ext-install gd
# MySQL
RUN docker-php-ext-install mysql

# Install msmtp
RUN apt-get -y --no-install-recommends install msmtp

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
