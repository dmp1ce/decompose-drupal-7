FROM busybox
MAINTAINER David Parrish <daveparrish@tutanota.com>

# Source directory. May be deleted from time to time to refresh source.

COPY {{PROJECT_SOURCE_PATH}} {{PROJECT_SOURCE_CONTAINER_PATH}}

# Set the correct permissions for settings.php
RUN chmod -w {{PROJECT_SOURCE_CONTAINER_PATH}}/sites/default/settings.php
