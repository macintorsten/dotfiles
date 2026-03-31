# Dotfiles

Configs managed with [GNU Stow](https://www.gnu.org/software/stow/). CLI tools managed with [mise](https://mise.jdx.dev/).

## Setup

```bash
git clone https://github.com/macintorsten/dotfiles.git ~/.dotfiles
bash ~/.dotfiles/bootstrap.sh
cd ~/.dotfiles && stow */
source ~/.bashrc
```

`bootstrap.sh` is intentionally rootless: install `stow`, `git`, and `curl` yourself first if they are missing.

## Tools

Global tools are defined in `mise/.config/mise/config.toml`. The config now prefers mise's built-in tool names and default backends where they are available, keeping a direct `http:` source only for `tldr` because it does not currently have a default registry entry in this setup. `bootstrap.sh` installs `mise` into `~/.local/bin`, installs the configured tools, and shell startup exposes both `mise` and its shims so globally installed tools also work in non-login shells.

The current pinned release URLs target Linux x86_64, which matches the current WSL setup. If you want to use the repo on another platform later, extend the `mise` config with additional platform-specific URLs.

```bash
mise install          # install everything from config.toml
mise exec -- jq --version
```

## Update tools

```bash
mise outdated
mise upgrade --bump   # bump pinned versions in config.toml
mise install
```

## Node projects

`fnm` has been replaced with `mise`. The config enables Node idiomatic version files, so `.nvmrc`-based projects can still work once you install a Node version with `mise use -g node@lts`.

## Test

```bash
./test.sh      # build Docker image
./test.sh -i   # interactive shell
```
