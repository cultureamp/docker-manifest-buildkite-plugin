#!/usr/bin/env bats

setup() {
  load "$BATS_PLUGIN_PATH/load.bash"

  # Uncomment to enable stub debugging
  # export GIT_STUB_DEBUG=/dev/tty
}

@test "Checkout is disabled by default" {
  export BUILDKITE_REPO="test-repo-value"

  source "$PWD/hooks/pre-checkout"

  assert [ -z "${BUILDKITE_REPO}" ]
}

@test "Checkout is disabled when argument false" {
  export BUILDKITE_REPO="test-repo-value"
  export BUILDKITE_PLUGIN_DOCKER_MANIFEST_ALLOW_CHECKOUT="false"

  source "$PWD/hooks/pre-checkout"

  assert [ -z "${BUILDKITE_REPO}" ]
}

@test "Checkout is enabled when argument true" {
  export BUILDKITE_REPO="test-repo-value"
  export BUILDKITE_PLUGIN_DOCKER_MANIFEST_ALLOW_CHECKOUT="true"

  source "$PWD/hooks/pre-checkout"

  assert [ "${BUILDKITE_REPO}" == "test-repo-value" ]
}
