FROM dmp1ce/php-fpm-drupal
MAINTAINER David Parrish <daveparrish@tutanota.com>

# Use the default php.ini depending on $environment.
RUN cp /usr/src/php/php.ini-{{PROJECT_ENVIRONMENT}} /usr/local/etc/php/php.ini

# Add msmtp settings
COPY msmtp/msmtp_php /etc/msmtp_php
RUN chmod 600 /etc/msmtp_php && chown www-data:www-data /etc/msmtp_php && \
sed -i 's|;sendmail_path =$|sendmail_path = "{{PROJECT_SENDMAIL_PATH}}"|g' /usr/local/etc/php/php.ini

# disable mbstring.http_input and mbstring.http_output
RUN sed -i 's|;mbstring.http_input =$|mbstring.http_input = pass|g' /usr/local/etc/php/php.ini
RUN sed -i 's|;mbstring.http_output =$|mbstring.http_output = pass|g' /usr/local/etc/php/php.ini

# Set timezone
RUN sed -i 's|;date.timezone =$|date.timezone = "{{PROJECT_PHP_TIMEZONE}}"|g' /usr/local/etc/php/php.ini

# Add mail_catch script
COPY mail_catch /opt/mail_catch
RUN chmod +x /opt/mail_catch

# Set working directory
WORKDIR /srv/http/source
