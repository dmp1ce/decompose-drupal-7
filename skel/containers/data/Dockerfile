FROM busybox
MAINTAINER David Parrish <daveparrish@tutanota.com>

# Persistant data container

# Mount writable directories so they don't get changed on the host by accident
RUN install -dm777 /srv/http/source/sites/default/files && \
chmod -R 777 /srv/http/source/sites/default/files

# Private files
RUN install -dm777 /srv/http/source/sites/default/private && \
chmod -R 777 /srv/http/source/sites/default/private

VOLUME /srv/http/source/sites/default/files
VOLUME /srv/http/source/sites/default/private
