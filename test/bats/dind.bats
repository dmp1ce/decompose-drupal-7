#!/usr/bin/env bats

#TESTER_IMAGE="docker run --rm --link decompose-docker-drupal7-testing:docker docker run --rm tester"

@test "Default decompose build && decompose up" {
  # Run decompose with fixture in place.
  local project_directory=$(readlink -f "$BATS_TEST_DIRNAME/../../")
  run docker run -v $project_directory:/project --rm --link \
decompose-docker-drupal7-testing:docker decompose_build_environment sh -c \
"cp -rL /project /project-no-symlinks && \
cp -rL /project-no-symlinks/skel/. /app && \
cp -rL /project-no-symlinks /app/.decompose/environment && \
echo \"PROJECT_DOCKER_LOG_DRIVER=none\" >> /app/.decompose/elements && \
decompose build && decompose up && docker-compose ps && docker ps"
}

# vim:syntax=sh tabstop=2 shiftwidth=2 expandtab
