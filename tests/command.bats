#!/usr/bin/env bats

load '/usr/local/lib/bats/load.bash'

# Uncomment the following line to debug stub failures
# export BUILDKITE_AGENT_STUB_DEBUG=/dev/tty

@test "Fails when image-name not provided" {
  run "$PWD/hooks/command"

  assert_failure
  assert_output --partial "No 'image-name' argument provided"
}

@test "Fails when source-image-names not provided" {
  export BUILDKITE_PLUGIN_DOCKER_MANIFEST_IMAGE_NAME="image-name"

  run "$PWD/hooks/command"

  assert_failure
  assert_output --partial "No 'source-image-names' argument provided"
}

@test "When configuration is specified, it creates and pushes a docker manifest"  {
  export BUILDKITE_PLUGIN_DOCKER_MANIFEST_IMAGE_NAME="image-name"
  export BUILDKITE_PLUGIN_DOCKER_MANIFEST_SOURCE_IMAGE_NAMES_0="source-one"
  export BUILDKITE_PLUGIN_DOCKER_MANIFEST_SOURCE_IMAGE_NAMES_1="source-two"

  stub docker \
    ':: echo stubbed docker $@' \
    ':: echo stubbed docker $@'

  run "$PWD/hooks/command"

  assert_success
  assert_line --partial "stubbed docker manifest create image-name source-one source-two"
  assert_line --partial "stubbed docker manifest push image-name"

  unstub docker
}
