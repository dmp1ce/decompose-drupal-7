FROM nginx:latest
MAINTAINER David Parrish <daveparrish@tutanota.com>

# Install wget and install/updates certificates
RUN apt-get update \
 && apt-get install -y -q --no-install-recommends \
    ca-certificates \
    wget \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

# Install Forego
RUN wget -P /usr/local/bin https://godist.herokuapp.com/projects/ddollar/foreg\
o/releases/current/linux-amd64/forego && chmod u+x /usr/local/bin/forego

# Copy nginx config files
COPY default.conf /etc/nginx/conf.d/default.conf

# Copy application scripts
COPY app/. /app/
WORKDIR /app/

# Change command to run forego instead of nginx
CMD ["forego", "start", "-r"]
