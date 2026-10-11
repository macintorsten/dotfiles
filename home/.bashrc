for f in "$HOME/.config/bashrc.d"/*.sh; do
  [ -r "$f" ] && . "$f"
done
unset f
