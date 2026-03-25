#!/usr/bin/env bash
_fzf_cache="${XDG_CACHE_HOME:-$HOME/.cache}/fzf-init.bash"
if [ ! -f "$_fzf_cache" ] && command -v fzf &>/dev/null; then
    mkdir -p "${_fzf_cache%/*}"
    fzf --bash > "$_fzf_cache"
fi
[ -f "$_fzf_cache" ] && source "$_fzf_cache"
unset _fzf_cache
export FZF_CTRL_T_OPTS="--preview '[ -d {} ] && ls -lah --color=always {} || (bat --style=numbers --color=always {} 2>/dev/null || cat {})'"
export FZF_ALT_C_OPTS="--preview 'ls -lah --color=always {}'"
export FZF_CTRL_R_OPTS="--preview 'echo {} | sed \"s/^[0-9]*\s*//\" | bat --style=plain --color=always -l bash' --preview-window down:3:wrap"
export FZF_COMPLETION_OPTS="--preview '[ -d {} ] && ls -lah --color=always {} || (bat --style=numbers --color=always {} 2>/dev/null || cat {})'"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --multi --bind 'ctrl-a:select-all,ctrl-d:deselect-all'"
