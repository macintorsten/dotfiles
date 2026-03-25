#!/bin/bash
set -e

REPO="$(cd "$(dirname "$0")" && pwd)"
AQUA_BIN="${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua/bin/aqua"
BASHRC_LINE='[ -f "$HOME/.bashrc.d" ] && . "$HOME/.bashrc.d"'

# stow
if ! command -v stow &>/dev/null; then
    if   [ -f /etc/debian_version ]; then sudo apt-get update && sudo apt-get install -y stow
    elif [ -f /etc/redhat-release ]; then sudo yum install -y epel-release && sudo yum install -y stow
    elif [ -f /etc/arch-release ];   then sudo pacman -Sy --noconfirm stow
    elif [ -f /etc/alpine-release ]; then sudo apk add stow
    else echo "Unsupported distro. Install stow manually." && exit 1
    fi
fi

# aqua
[ -f "$AQUA_BIN" ] || curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/main/aqua-installer | bash

# tpm
[ -d "$HOME/.tmux/plugins/tpm" ] || git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

# bashrc integration (once)
grep -qF "$BASHRC_LINE" "$HOME/.bashrc" 2>/dev/null || echo "$BASHRC_LINE" >> "$HOME/.bashrc"

# install aqua tools
AQUA_GLOBAL_CONFIG="$REPO/aqua/.config/aquaproj-aqua/aqua.yaml" "$AQUA_BIN" install --all
