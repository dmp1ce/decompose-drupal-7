#!/bin/bash
/bin/sed -i "s/<php-fpm-ip>/${PHP_1_PORT_9000_TCP_ADDR}/" /etc/nginx/conf.d/default.conf
/bin/sed -i "s/<php-fpm-port>/${PHP_1_PORT_9000_TCP_PORT}/" /etc/nginx/conf.d/default.conf

echo "Starting nginx"
nginx -g "daemon off;"
