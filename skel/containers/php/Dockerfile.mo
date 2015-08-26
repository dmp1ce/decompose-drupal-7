FROM php:{{PROJECT_PHP_VERSION}}
MAINTAINER David Parrish <daveparrish@tutanota.com>

# Update Debian (so additional software can be installed with apt-get)
RUN apt-get -y update && \
apt-get -y upgrade

# Install required PHP extensions.
# gd
RUN apt-get -y install libgd-dev libjpeg62-turbo-dev && \
docker-php-ext-configure gd --with-jpeg-dir=/usr/include && \
docker-php-ext-install gd
# MySQL
RUN docker-php-ext-install mysql

# Use the default php.ini depending on $environment.
RUN cp /usr/src/php/php.ini-{{PROJECT_ENVIRONMENT}} /usr/local/etc/php/php.ini

# Set working directory
WORKDIR /srv/http/source
