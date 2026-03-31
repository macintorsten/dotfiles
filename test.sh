#!/bin/bash
set -e
docker build -t config-test "$(dirname "$0")"
if [ "$1" = "-i" ] || [ "$1" = "--interactive" ]; then
    docker run --rm -it config-test bash
fi
