#!/bin/bash

{{#PRODUCTION}}

# Include '.*' pattern in globbing. http://unix.stackexchange.com/a/6397/55139
shopt -s dotglob nullglob

# Update all the souce in the build volume
echo "Updating source in shared build volume"

mkdir -p {{PROJECT_BUILD_PATH}}/build/drupal
rm -rf {{PROJECT_BUILD_PATH}}/build/drupal/*
cp -r {{PROJECT_BUILD_PATH}}/docker_build_context/source/drupal/* {{PROJECT_BUILD_PATH}}/build/drupal

overrides_to_add=( 'themes' 'modules' 'libraries' )

mkdir -p {{PROJECT_BUILD_PATH}}/build/drupal/sites/all
for override in "${overrides_to_add[@]}"; do
  if [ -d "{{PROJECT_BUILD_PATH}}/docker_build_context/source/${override}" ]; then
    cp -r {{PROJECT_BUILD_PATH}}/docker_build_context/source/${override} {{PROJECT_BUILD_PATH}}/build/drupal/sites/all
  fi
done
{{/PRODUCTION}}
{{#DEVELOPMENT}}
echo "Updating source from docker_build_context. Will NOT override files which already exist."
echo "See decompose to force Drupal to update."
cp -rn {{PROJECT_BUILD_PATH}}/docker_build_context/source/drupal/* {{PROJECT_BUILD_PATH}}/build/drupal
{{/DEVELOPMENT}}

chmod +w {{PROJECT_BUILD_PATH}}/build/drupal/sites/default
# Copy settings.php and services.yml
cp -f {{PROJECT_BUILD_PATH}}/docker_build_context/source/settings.php {{PROJECT_BUILD_PATH}}/build/drupal/sites/default

# Create files symlink
ln -sf /app/files/public {{PROJECT_BUILD_PATH}}/build/drupal/sites/default/files
chmod -w {{PROJECT_BUILD_PATH}}/build/drupal/sites/default

{{#DEVELOPMENT}}
# Don't worry about chmod failing for development.
exit 0
{{/DEVELOPMENT}}

# vim: syntax=sh
