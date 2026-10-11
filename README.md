# Dotfiles

This repository is a setup seed, not the dotfiles sync remote. mise tracks files
where they live, keeps their history, and can sync that history to a separate
private Git repository. `home/` preserves the previous setup as a migration
reference; merge only the settings and files you need into your live home
directory. The starter global config is
[`home/.config/mise/config.toml`](home/.config/mise/config.toml).

## First machine

Install mise if needed:

```sh
curl -fsSL https://mise.run | sh
export PATH="$HOME/.local/bin:$PATH"
```

Merge the starter config into `~/.config/mise/config.toml`, then track the
config and the files you already use. Include your shell and application
configuration; for example:

```sh
mise dot track ~/.config/mise/config.toml ~/.bashrc ~/.bash_profile ~/.vimrc \
  ~/.config/nvim ~/.config/tmux ~/.config/git/config
mise bootstrap
mise dot origin set https://github.com/you/private-dotfiles.git --sync sync
```

Use a private, separate repository as the origin: syncing publishes saved file
history, not just current contents. If you are migrating from this repo's old
symlink setup, first make sure the paths you track are regular files and their
contents are preserved; do not remove the old checkout until tracking succeeds.

## Another machine

Install Git and mise, authenticate with your Git host, then restore the setup:

```sh
mise bootstrap --adopt you/private-dotfiles
mise dot status
```

## Check the setup

Edit a tracked file, then verify it was saved and synced:

```sh
mise dot save ~/.bashrc
mise dot sync
mise dot status
```

On another machine, verify the change arrives. A clean machine can be tested
with `mise bootstrap --adopt you/private-dotfiles`.
