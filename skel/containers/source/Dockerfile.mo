FROM dmp1ce/php-fpm-drupal:5
MAINTAINER David Parrish <daveparrish@tutanota.com>

# Copy all the source
COPY ./ {{PROJECT_BUILD_PATH}}/docker_build_context

# Fix ownership
# Make scripts executable
# Download Drupal source
RUN groupadd -g {{PROJECT_HOST_GROUPID}} -o hostuser && \
useradd -m -u {{PROJECT_HOST_USERID}} -g {{PROJECT_HOST_GROUPID}} hostuser && \
chown -R {{PROJECT_HOST_USERID}}:{{PROJECT_HOST_GROUPID}} {{PROJECT_BUILD_PATH}}/docker_build_context && \
chmod +rx {{PROJECT_BUILD_PATH}}/docker_build_context/*.bash && sync && \
su -c '{{PROJECT_BUILD_PATH}}/docker_build_context/make.bash "{{PROJECT_BUILD_PATH}}/docker_build_context/source/drupal"' hostuser

USER hostuser
