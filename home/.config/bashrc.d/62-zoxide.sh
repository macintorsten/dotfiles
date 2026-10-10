#!/usr/bin/env bash
_zoxide_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zoxide-init.bash"
if [ ! -f "$_zoxide_cache" ] && command -v zoxide &>/dev/null; then
    mkdir -p "${_zoxide_cache%/*}"
    zoxide init bash --hook pwd > "$_zoxide_cache"
fi
[ -f "$_zoxide_cache" ] && source "$_zoxide_cache"
unset _zoxide_cache
