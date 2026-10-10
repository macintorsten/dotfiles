#!/usr/bin/env bash
command -v fzf &>/dev/null && eval "$(fzf --bash)"
export FZF_CTRL_T_OPTS="--preview '[ -d {} ] && ls -lah --color=always {} || (bat --style=numbers --color=always {} 2>/dev/null || cat {})'"
export FZF_ALT_C_OPTS="--preview 'ls -lah --color=always {}'"
export FZF_CTRL_R_OPTS="--preview 'echo {} | sed \"s/^[0-9]*\s*//\" | bat --style=plain --color=always -l bash' --preview-window down:3:wrap"
export FZF_COMPLETION_OPTS="--preview '[ -d {} ] && ls -lah --color=always {} || (bat --style=numbers --color=always {} 2>/dev/null || cat {})'"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --multi --bind 'ctrl-a:select-all,ctrl-d:deselect-all'"
