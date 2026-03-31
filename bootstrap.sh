#!/bin/bash
set -e

REPO="$(cd "$(dirname "$0")" && pwd)"
MISE_BIN="${HOME}/.local/bin/mise"
MISE_GLOBAL_CONFIG_FILE="$REPO/mise/.config/mise/config.toml"
BASHRC_LINE='[ -f "$HOME/.bashrc.d" ] && . "$HOME/.bashrc.d"'

if ! command -v stow &>/dev/null; then
    echo "stow is required but is not installed. Install it yourself before running 'stow */'."
fi

# mise
if [ ! -x "$MISE_BIN" ]; then
    mkdir -p "${MISE_BIN%/*}"
    curl -fsSL https://mise.run | MISE_INSTALL_PATH="$MISE_BIN" sh
fi

# tpm
[ -d "$HOME/.tmux/plugins/tpm" ] || git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

# vim-plug
[ -f "$HOME/.vim/autoload/plug.vim" ] || curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# bashrc integration (once)
grep -qF "$BASHRC_LINE" "$HOME/.bashrc" 2>/dev/null || echo "$BASHRC_LINE" >> "$HOME/.bashrc"

# install mise tools from the repo's global config
for attempt in 1 2 3 4 5; do
    if MISE_GLOBAL_CONFIG_FILE="$MISE_GLOBAL_CONFIG_FILE" "$MISE_BIN" install; then
        break
    fi

    if [ "$attempt" -eq 3 ]; then
        echo "mise install failed after $attempt attempts."
        exit 1
    fi

    echo "mise install failed; retrying ($attempt/3)..."
    sleep $attempt
done
