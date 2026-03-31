#!/usr/bin/env bash
export MISE_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/mise"
export MISE_GLOBAL_CONFIG_FILE="${MISE_GLOBAL_CONFIG_FILE:-$MISE_CONFIG_DIR/config.toml}"

if command -v mise &>/dev/null; then
    eval "$(mise activate bash)"
fi
