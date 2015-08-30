php:
  build: containers/php/.
  volumes_from:
    - source
    - data
  links:
    - db
{{#PRODUCTION}}
  restart: always
{{/PRODUCTION}}
nginx:
  build: containers/nginx/.
  links:
    - php
  volumes_from:
    - source
    - data
  environment:
    - VIRTUAL_HOST={{PROJECT_NGINX_VIRTUAL_HOST}}
{{#PRODUCTION}}
  restart: always
{{/PRODUCTION}}
db:
  image: mariadb
  environment:
    MYSQL_ROOT_PASSWORD: dont_use_root_user
    MYSQL_USER: app_user
    MYSQL_PASSWORD: password
    MYSQL_DATABASE: app
{{#PRODUCTION}}
  restart: always
{{/PRODUCTION}}
# Data containers
source:
  build: containers/source/.
  volumes:
    - {{#DEVELOPMENT}}{{SOURCE_VOLUME_HOST}}:{{/DEVELOPMENT}}{{SOURCE_VOLUME_CONTAINER}}
  command: "true"
data:
  build: containers/data/.
  command: "true"
# Backup
backup:
  build: containers/backup/.
  command: "/home/duply/backup_service"
  volumes_from:
    - data{{#DEVELOPMENT}}
    - backup_data{{/DEVELOPMENT}}
  links:
    - db
{{#DEVELOPMENT}}
backup_data:
  build: containers/backup_data/.
  command: "true"
{{/DEVELOPMENT}}

# vim:syntax=yaml
