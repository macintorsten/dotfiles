#!/bin/bash
set -e

docker_build_args=(-t config-test)
if [ -n "${MISE_GITHUB_TOKEN:-}" ]; then
    docker_build_args+=(--secret id=MISE_GITHUB_TOKEN,env=MISE_GITHUB_TOKEN)
fi

docker buildx build --load "${docker_build_args[@]}" "$(dirname "$0")"
if [ "$1" = "-i" ] || [ "$1" = "--interactive" ]; then
    docker run -e "MISE_GITHUB_TOKEN=${MISE_GITHUB_TOKEN}" --rm -it config-test bash
fi
