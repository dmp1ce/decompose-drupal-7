php:
  build: containers/php/.
  command: /opt/start_php_fpm.sh
  volumes_from:
    - source
    - data
  links:
    - db
nginx:
  build: containers/nginx/.
  links:
    - php
  command: /start_nginx.sh
  volumes_from:
    - source
    - data
  environment:
    - VIRTUAL_HOST={{PROJECT_NGINX_VIRTUAL_HOST_DEV}}
db:
  image: mariadb
  environment:
    MYSQL_ROOT_PASSWORD: dont_use_root_user
    MYSQL_USER: app_user
    MYSQL_PASSWORD: password
    MYSQL_DATABASE: app
# Data containers
source:
  build: containers/source/.
  volumes:
    - {{SOURCE_VOLUME2}}
  command: "true"
data:
  build: containers/data/.
  command: "true"

# vim:syntax=yaml
