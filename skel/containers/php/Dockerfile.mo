FROM php:{{PROJECT_PHP_VERSION}}
MAINTAINER David Parrish <daveparrish@tutanota.com>

# Use the default php.ini depending on $environment.
RUN cp /usr/src/php/php.ini-{{PROJECT_ENVIRONMENT}} /usr/local/etc/php/php.ini

# Add script for running service
COPY start_php_fpm.sh /opt/start_php_fpm.sh

# Set working directory
WORKDIR /srv/http/source
