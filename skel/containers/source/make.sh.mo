#!/bin/bash

# Make if make.yml exists
if [ -f "{{PROJECT_SOURCE_CONTAINER_PATH}}/make.yml" ]; then
  cd "{{PROJECT_SOURCE_CONTAINER_PATH}}"
  drush make -y make.yml
fi

# If a settings.php file is missing but a default.settings.php create settings.php
if [ ! -f "{{PROJECT_SOURCE_CONTAINER_PATH}}/sites/default/settings.php" ] && \
  [ -f "{{PROJECT_SOURCE_CONTAINER_PATH}}/sites/default/default.settings.php" ]; then
  #cp {{PROJECT_SOURCE_CONTAINER_PATH}}/sites/default/default.settings.php \
  #  {{PROJECT_SOURCE_CONTAINER_PATH}}/sites/default/settings.php

  # Configure settings.php
  sed "s/\$databases = array();/\$databases = array (\\
  'default' =>\\
  array (\\
    'default' =>\\
    array (\\
      'database' => '{{PROJECT_DB_DATABASE}}',\\
      'username' => '{{PROJECT_DB_USER}}',\\
      'password' => '{{PROJECT_DB_PASSWORD}}',\\
      'host' => 'db',\\
      'port' => '',\\
      'driver' => 'mysql',\\
      'prefix' => '',\\
    ),\\
  ),\\
);/" {{PROJECT_SOURCE_CONTAINER_PATH}}/sites/default/default.settings.php \
  > {{PROJECT_SOURCE_CONTAINER_PATH}}/sites/default/settings.php
  chmod a+w {{PROJECT_SOURCE_CONTAINER_PATH}}/sites/default/settings.php
fi
