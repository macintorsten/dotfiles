#!/usr/bin/env bash
_fnm_cache="${XDG_CACHE_HOME:-$HOME/.cache}/fnm-init.bash"
if [ ! -f "$_fnm_cache" ] && command -v fnm &>/dev/null; then
    mkdir -p "${_fnm_cache%/*}"
    fnm env --use-on-cd --shell bash > "$_fnm_cache"
fi
[ -f "$_fnm_cache" ] && source "$_fnm_cache"
unset _fnm_cache
