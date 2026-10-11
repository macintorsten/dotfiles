# AI Agent Guide

mise manages the shared tool, package, shell activation, and history-watcher
setup. The starter global config is `home/.config/mise/config.toml`; merge it
into `~/.config/mise/config.toml` on the first machine, then track the live
config and other files with `mise dot track`.

The `home/` tree is a migration snapshot from the former symlink setup. It is
not installed or updated automatically. Ongoing file history and cross-machine
sync belong to mise and a separate private Git origin.

Keep documentation focused on the essential track, sync, and adopt workflow.
