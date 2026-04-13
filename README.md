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

## Vim

The Vim config uses `vim-fugitive` and `fzf.vim` for lightweight git navigation:

- `Ctrl+P` opens `:GFiles`
- `<Leader>gg` runs a repo-scoped `git grep` for the current word, or the visual selection, and opens quickfix
- `<Leader>gs` opens Fugitive status
- `<Leader>gd` opens a vertical git diff
- `<Leader>gb` opens git blame

If you want a small LSP upgrade later without changing editors, `vim-lsp` plus `asyncomplete.vim` would fit this setup well.

## Neovim

The Neovim config lives under `nvim/.config/nvim` and is intended to coexist with Vim rather than replace it.

- The config targets Neovim 0.12+ for the smoothest experience, while keeping a few small compatibility shims for older releases where that does not require dropping features.
- It keeps the core shortcuts familiar: `Ctrl+P` for git files, `Ctrl+F` for files, `Ctrl+B` for buffers, and `<Leader>gg` / `<Leader>gs` / `<Leader>gd` / `<Leader>gb` for git workflows.
- Plugins are bootstrapped with `lazy.nvim`, navigation uses `fzf-lua`, git uses `vim-fugitive` plus `gitsigns`, and LSP/completion use `mason.nvim`, `nvim-lspconfig`, and `nvim-cmp`.
- Use `:Colors` or `<Leader>fc` to preview installed colorschemes with live updates.
- `mise install` also provides the Node host (`npm:neovim`) and `tree-sitter-cli` so Neovim health checks stay cleaner.
- Install the `neovim` binary with your system package manager, then the first `nvim` launch will install plugins automatically.
- Java support is wired through `nvim-jdtls`; install `jdtls` from `:Mason`, and the config ensures the Java treesitter parser so once a JDK is available, opening a Maven/Gradle/git-backed Java project should mostly just work.

## Test

```bash
./test.sh      # build Docker image
./test.sh -i   # interactive shell
```
