if [ -d "$HOME/.config/bashrc.d" ]; then
    for f in "$HOME/.config/bashrc.d"/*.sh; do [ -f "$f" ] && . "$f"; done
fi
