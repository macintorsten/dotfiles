#!/usr/bin/env bash
if command -v oh-my-posh &>/dev/null; then
    _omp_cache="${XDG_CACHE_HOME:-$HOME/.cache}/oh-my-posh-init.bash"
    _omp_config="$HOME/.config/oh-my-posh/amro.omp.json"
    if [ ! -f "$_omp_cache" ] || [ "$_omp_config" -nt "$_omp_cache" ]; then
        oh-my-posh init bash --config "$_omp_config" > "$_omp_cache"
    fi
    source "$_omp_cache"
    unset _omp_cache _omp_config
fi
