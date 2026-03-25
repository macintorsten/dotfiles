#!/bin/bash
set -e
docker build -t config-test "$(dirname "$0")"
[ "$1" = "-i" ] || [ "$1" = "--interactive" ] && docker run --rm -it config-test bash
