#!/usr/bin/env bash
command -v bat &>/dev/null && export FZF_DEFAULT_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
