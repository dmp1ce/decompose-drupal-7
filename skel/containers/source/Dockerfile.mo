FROM busybox
MAINTAINER David Parrish <daveparrish@tutanota.com>

# Source directory. May be deleted from time to time to refresh source.

COPY {{PROJECT_SOURCE_PATH}} {{PROJECT_SOURCE_CONTAINER_PATH}}
