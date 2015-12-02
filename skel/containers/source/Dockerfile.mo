#FROM busybox
FROM dmp1ce/php-fpm-drupal
MAINTAINER David Parrish <daveparrish@tutanota.com>

# Source directory. Will be deleted on rebuilds to refresh source.

# Copy source
COPY {{PROJECT_SOURCE_PATH}} {{PROJECT_SOURCE_CONTAINER_PATH}}

# Use make.sh script for setting up source
COPY make.sh /srv/http/make.sh
RUN chmod +rx /srv/http/make.sh && sync && /srv/http/make.sh

# Copy overrides (Uncomment to enable overrides)
# Copy modules
#COPY {{PROJECT_SOURCE_PATH}}/../modules {{PROJECT_SOURCE_CONTAINER_PATH}}/sites/all/modules/_overrides
# Copy themes
#COPY {{PROJECT_SOURCE_PATH}}/../themes {{PROJECT_SOURCE_CONTAINER_PATH}}/sites/all/themes/_overrides
# Copy libraries
#COPY {{PROJECT_SOURCE_PATH}}/../libraries {{PROJECT_SOURCE_CONTAINER_PATH}}/sites/all/libraries/_overrides
