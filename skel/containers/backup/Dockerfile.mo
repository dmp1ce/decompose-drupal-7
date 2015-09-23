FROM debian:jessie
MAINTAINER David Parrish <daveparrish@tutanota.com>

# Update Debian.
# install requirements (duply, mariadb-client, ssh)
RUN apt-get -y update && \
apt-get install -y -q --no-install-recommends \
  ca-certificates \
  duply \
  mariadb-client \
  openssh-client \
  python-paramiko \
&& apt-get clean \
&& rm -r /var/lib/apt/lists/*

# Create user to run backups
RUN useradd -m -s /bin/bash duply

# Copy duply profiles
COPY .duply/ /home/duply/.duply
RUN chmod -R 700 /home/duply/.duply &&\
  chown -R duply:duply /home/duply/.duply
# Copy ssh keys
COPY .ssh/ /home/duply/.ssh
RUN chmod -R 700 /home/duply/.ssh &&\
  chown -R duply:duply /home/duply/.ssh

# Create directory for exporting sql
RUN mkdir -p /srv/http/sql_backup && chmod 777 /srv/http/sql_backup

# Run as user
USER duply

# Build site
WORKDIR /home/duply

# For development backups
RUN mkdir /home/duply/backup && touch /home/duply/backup/.keep

# Copy backup service script
COPY backup_service /home/duply/backup_service

# Run backup service script by default
CMD /home/duply/backup_service
