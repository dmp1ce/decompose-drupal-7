#!/usr/bin/env bats

#TESTER_IMAGE="docker run --rm --link decompose-docker-drupal7-testing:docker docker run --rm tester"
#
# These tests build the Docker Compose containers and verify their functionality.
#
# Order of these tests is important because they build up the project, test some things and then cleanup. The reason for this is because building the project takes so long. Every tests building the project would take such a long time that it wouldn't be worth running the tests frequently.

load "$BATS_TEST_DIRNAME/bats_functions.bash"

@test "'decompose build' builds containers without error" {
  cd "$WORKING"
  run decompose build

  echo $output
  [ "$status" -eq 0 ]
}

@test "'decompose up' starts containers without error" {
  cd "$WORKING"
  decompose --build
  run decompose up

  echo $output
  [ "$status" -eq 0 ]
}

@test "'docker-compose ps' shows containers up" {
  cd "$WORKING"
  decompose --build
  run docker-compose ps
  
  echo "$output"
  [ "${#lines[@]}" -gt 2 ]
}

@test "Stop project" {
  cd "$WORKING"
  decompose --build
  docker-compose stop
  decompose stop_nginx_proxy
}

@test "Remove project" {
  cd "$WORKING"
  decompose --build
  docker-compose rm -f
  docker rm nginx_proxy
}


function setup() {
  setup_testing_environment
  
} 

function teardown() {
  teardown_testing_environment
}

# vim:syntax=sh tabstop=2 shiftwidth=2 expandtab