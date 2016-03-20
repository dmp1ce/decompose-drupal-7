FROM dduportal/docker-compose
MAINTAINER David Parrish <daveparrish@tutanota.com>

# Merged some of docker Dockerfile build.
# See: https://github.com/docker-library/docker/blob/master/1.10/Dockerfile

# Setup entrypoint
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]

# Install decompose and docker
ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.10.3
ENV DOCKER_SHA256 d0df512afa109006a450f41873634951e19ddabf8c7bd419caeb5a526032d86d
RUN mkdir -p /opt/decompose && \
apt-get update -y && \
apt-get install -y --no-install-recommends git ca-certificates && \
git clone --recursive https://github.com/dmp1ce/decompose.git /opt/decompose && \
ln -s /opt/decompose/decompose /usr/local/bin && \
chmod +x /usr/local/bin/docker-entrypoint.sh && \
curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-$DOCKER_VERSION" -o /usr/local/bin/docker && \
echo "${DOCKER_SHA256} /usr/local/bin/docker" | sha256sum -c - && \
chmod +x /usr/local/bin/docker
