#!/usr/bin/env bash
export MISE_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/mise"
export MISE_SHIMS_DIR="${MISE_SHIMS_DIR:-$MISE_DATA_DIR/shims}"
export PATH="$HOME/.local/bin:$MISE_SHIMS_DIR:$PATH"
