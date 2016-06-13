#!/usr/bin/env bats

# These tests build the Docker Compose containers and verify their functionality.
#
# Order of these tests is important because they build up the project, test some things and then cleanup. The reason for this is because building the project takes so long. Every tests building the project would take such a long time that it wouldn't be worth running the tests frequently.

load "$BATS_TEST_DIRNAME/bats_functions.bash"

@test "[development] Custom build step" {
  cd "$WORKING"

  # Add custom build function to project processes
  echo "
_decompose-process-custom-build-steps() {
  touch 'custom-step-works'
}
" >> processes

  cat processes

  # Build
  run decompose build
  echo "$output"
  [ "$status" -eq 0 ]

  ls -alh

  # Verify file was created from build step
  [ -f custom-step-works ]
}

@test "[development] No custom build step" {
  cd "$WORKING"

  # Build
  run decompose build
  echo "$output"
  [ "$status" -eq 0 ]

  # Verify file was created from build step
  [ ! -f custom-step-works ]
}

function setup() {
  setup_testing_environment

  # Switch to development element
  echo 'PROJECT_ENVIRONMENT="development"' >> "$WORKING/.decompose/elements"
}

function teardown() {
  teardown_testing_environment
}

# vim:syntax=sh tabstop=2 shiftwidth=2 expandtab
