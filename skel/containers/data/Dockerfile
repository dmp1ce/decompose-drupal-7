FROM busybox
MAINTAINER David Parrish <daveparrish@tutanota.com>

# Persistant data container

# Mount writable directories so they don't get changed on the host by accident
RUN install -dm777 /srv/http/source/app/tmp/cache/models && \
install -dm777 /srv/http/source/app/tmp/cache/persistent && \
install -dm777 /srv/http/source/app/tmp/cache/views && \
install -dm777 /srv/http/source/app/tmp/logs && \
install -dm777 /srv/http/source/app/tmp/sessions && \
install -dm777 /srv/http/source/app/tmp/tests && \
install -dm777 /srv/http/source/app/webroot/img/cache && \
install -dm777 /srv/http/source/app/webroot/img/uploads && \
chmod -R 777 /srv/http/source/app/tmp && \
chmod -R 777 /srv/http/source/app/webroot/img/cache && \
chmod -R 777 /srv/http/source/app/webroot/img/uploads

VOLUME /srv/http/source/app/tmp
VOLUME /srv/http/source/app/webroot/img/uploads
VOLUME /srv/http/source/app/webroot/img/cache
