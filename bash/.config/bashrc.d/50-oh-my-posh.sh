#!/usr/bin/env bash
# Oh My Posh prompt configuration

if command -v oh-my-posh &> /dev/null; then
    eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/amro.omp.json)"
fi
