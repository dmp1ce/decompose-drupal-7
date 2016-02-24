php:
  build: containers/php/.
  volumes_from:
    - source
    - data
  links:
    - db
  environment:
    TERM: dumb
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
    - VIRTUAL_HOST={{PROJECT_NGINX_PROXY_VIRTUAL_HOSTS}}
{{#PROJECT_LETSENCRYPT}}
    - LETSENCRYPT_HOST={{PROJECT_NGINX_PROXY_VIRTUAL_HOSTS}}
    - LETSENCRYPT_EMAIL={{PROJECT_LETSENCRYPT_EMAIL}}
{{/PROJECT_LETSENCRYPT}}
{{#PRODUCTION}}
  restart: always
{{/PRODUCTION}}
db:
  image: mariadb
  environment:
    MYSQL_ROOT_PASSWORD: {{PROJECT_DB_ROOT_PASSWORD}}
    MYSQL_USER: {{PROJECT_DB_USER}}
    MYSQL_PASSWORD: {{PROJECT_DB_PASSWORD}}
    MYSQL_DATABASE: {{PROJECT_DB_DATABASE}}
    TERM: dumb
{{#PRODUCTION}}
  restart: always
{{/PRODUCTION}}
# Data containers
source:
  build: containers/source/.
  volumes:
    - {{PROJECT_SOURCE_CONTAINER_PATH}}
    # Uncomment to enable overrides
    #- {{#DEVELOPMENT}}{{PROJECT_SOURCE_HOST_PATH}}:{{/DEVELOPMENT}}{{PROJECT_SOURCE_CONTAINER_PATH}}
    #- {{#DEVELOPMENT}}{{PROJECT_SOURCE_HOST_PATH}}/../modules:{{/DEVELOPMENT}}{{PROJECT_SOURCE_CONTAINER_PATH}}/sites/all/modules/_overrides
    #- {{#DEVELOPMENT}}{{PROJECT_SOURCE_HOST_PATH}}/../themes:{{/DEVELOPMENT}}{{PROJECT_SOURCE_CONTAINER_PATH}}/sites/all/themes/_overrides
    #- {{#DEVELOPMENT}}{{PROJECT_SOURCE_HOST_PATH}}/../libraries:{{/DEVELOPMENT}}{{PROJECT_SOURCE_CONTAINER_PATH}}/sites/all/libraries/_overrides
  command: "true"
  labels:
    - "data_container=true"
data:
  build: containers/data/.
  command: "true"
  labels:
    - "data_container=true"
# Backup
backup:
  build: containers/backup/.
  command: "/home/duply/backup_service"
  volumes_from:
    - data
    - backup_data
  links:
    - db
{{#PRODUCTION}}
  restart: always
{{/PRODUCTION}}
# Backup data container
backup_data:
  build: containers/backup_data/.
  command: "true"
  labels:
    - "data_container=true"

# vi: set tabstop=2 expandtab syntax=yaml:
