#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "========================================"
echo "  Dotfiles Configuration Repository"
echo "========================================"
echo ""
echo "This repository manages configuration files for:"
echo "  • bash, tmux, vim, fzf, oh-my-posh, bat"
echo ""
echo "Installation options:"
echo "  1. Configurations only (recommended if tools installed)"
echo "  2. Full installation (tools + configurations)"
echo ""
read -p "Install tools? [Y/n] " -n 1 -r
echo
echo ""

cd "$SCRIPT_DIR"

# Install stow if not available
if ! command -v stow &> /dev/null; then
    echo "Installing GNU Stow..."
    bash scripts/install-stow.sh
fi

# Install tools if requested (default: yes)
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    echo "→ Installing tools..."
    for script in scripts/install-*.sh; do
        if [ -f "$script" ] && [ "$script" != "scripts/install-stow.sh" ]; then
            tool=$(basename "$script" .sh | sed 's/install-//')
            echo "  Installing $tool..."
            bash "$script"
        fi
    done
    echo ""
fi

# Install configurations using stow
echo "→ Installing configurations..."
cd dotfiles

echo "  Packages: $(ls -d */ | tr -d '/')"
stow -t ~ */

# Add single-line bashrc.d sourcing if not already present
if ! grep -q ".bashrc.d" ~/.bashrc 2>/dev/null; then
    echo ""
    echo "Adding dotfiles sourcing to ~/.bashrc..."
    echo '[ -f "$HOME/.bashrc.d" ] && . "$HOME/.bashrc.d"' >> ~/.bashrc
    echo "✓ Added dotfiles sourcing"
fi

echo ""
echo "=== Installation Complete ==="
echo ""
echo "Next steps:"
echo "  1. Restart shell: source ~/.bashrc"
echo "  2. Start tmux and press Ctrl-a I to install plugins"
echo ""
echo "To remove configurations:"
echo "  cd ~/config/dotfiles && stow -D */"