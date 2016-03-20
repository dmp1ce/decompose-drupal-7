#!/bin/bash

# Requires DIR global variable which identifies script directory.

function setup_testing_environment() {
  echo "Setting up Docker testing environment ..."
  # Create dind daemon with a mount to project.
  echo "DinD service"
  testing_env_build=$(docker run --privileged --name decompose-docker-drupal7-testing -d docker:dind)
  [ ["$?" == "1" ] && echo "$testing_env_build" ]

  # Build decompose environment image
  echo "Decompose build environment"
  testing_env_build=$(docker build -t decompose_build_environment "$DIR"/decompose_environment/.)
  [ "$?" == "1" ] && echo "$testing_env_build"
}

function run_tests() {
  echo "Running BATS tests"
  bats "$DIR/bats/dind.bats"
}

function teardown_testing_environment() {
  echo "Teardown Docker testing environment ..."
  echo "DinD service"
  testing_env_cleanup=$(docker rm -f decompose-docker-drupal7-testing)
  [ "$?" == "1" ] && echo "$testing_env_cleanup"

  echo "decompose build environment"
  testing_env_cleanup=$(docker rmi -f decompose_build_environment)
  [ "$?" == "1" ] && echo "$testing_env_cleanup"
}
