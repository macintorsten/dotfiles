# Dotfiles

Dotfiles and CLI tools managed by [mise](https://mise.jdx.dev/) (`mise bootstrap` + `mise dotfiles`). Requires mise 2026.10.4+.

## Setup

Prerequisites: `git`, `curl`, and `sudo` (unless root) for the `apt:` packages on Debian/Ubuntu.

```bash
curl -fsSL https://mise.run | sh
~/.local/bin/mise bootstrap --from https://github.com/macintorsten/dotfiles.git
```

Open a new shell afterwards. If GitHub rate-limits tool downloads, set `MISE_GITHUB_TOKEN` first.

`--from` clones the repo to `~/.local/share/mise/bootstrap-repo` and runs [`mise.toml`](mise.toml): installs apt packages, clones tpm and vim-plug, symlinks `home/` into `~`, wires mise into bash, and installs the tools. Dotfiles are symlinks into that checkout, so edit them in place.

## Daily use

```bash
mise bootstrap --from https://github.com/macintorsten/dotfiles.git --update   # pull and re-apply

# these need the project config, so run them in the checkout
cd ~/.local/share/mise/bootstrap-repo
mise bootstrap --dry-run      # preview
mise bootstrap status         # tools, packages, shell
mise dot status               # dotfiles
mise dot add --group home ~/.config/foo/bar   # move an existing file into home/ and link it back
```

## Layout

- `home/` mirrors `$HOME`; every file in it is symlinked into place (one `dotfile_groups` entry).
- `home/.config/mise/config.toml` holds the global tools; `mise bootstrap` installs them.
- `mise.toml` is the machine setup (project config): apt packages, repos, shell integration, hooks, and the test task. Only used from the checkout.

## Tools

```bash
mise outdated
mise upgrade --bump   # bump pinned versions in home/.config/mise/config.toml
mise install
```

Versions and checksums are locked in `home/.config/mise/mise.lock` (tools: `lockfile = true`). After editing tools, refresh it for all platforms and commit it:

```bash
mise lock --global --platform linux-x64,linux-arm64,macos-arm64
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

The Neovim config lives under `home/.config/nvim` and is intended to coexist with Vim rather than replace it.

- The config targets Neovim 0.12+ for the smoothest experience, while keeping a few small compatibility shims for older releases where that does not require dropping features.
- It keeps the core shortcuts familiar: `Ctrl+P` for git files, `Ctrl+F` for files, `Ctrl+B` for buffers, and `<Leader>gg` / `<Leader>gs` / `<Leader>gd` / `<Leader>gb` for git workflows.
- Plugins are bootstrapped with `lazy.nvim`, navigation uses `fzf-lua`, git uses `vim-fugitive` plus `gitsigns`, and LSP/completion use `mason.nvim`, `nvim-lspconfig`, and `nvim-cmp`.
- Use `:Colors` or `<Leader>fc` to preview installed colorschemes with live updates.
- `mise install` also provides the Node host (`npm:neovim`) and `tree-sitter-cli` so Neovim health checks stay cleaner.
- `neovim` itself comes from mise; the first `nvim` launch installs plugins automatically.
- Java support is wired through `nvim-jdtls`; install `jdtls` from `:Mason`, and the config ensures the Java treesitter parser so once a JDK is available, opening a Maven/Gradle/git-backed Java project should mostly just work.

## Test

Needs Docker. Commit first: the test bootstraps `HEAD` from a clean Ubuntu container, twice, checks `mise bootstrap status --missing`, then drops you into a login shell. Tool downloads are cached in the Docker volume `dotfiles-test-mise-cache` (`docker volume rm dotfiles-test-mise-cache` for a fully cold run).

```bash
mise run test
```

Without mise, the same thing by hand:

```bash
git clone -q . /tmp/dotfiles-test && docker run --rm -it -v /tmp/dotfiles-test:/src:ro ubuntu:latest bash -c '
  apt-get update -qq && apt-get install -y -qq curl git ca-certificates &&
  git config --global --add safe.directory "*" &&
  curl -fsSL https://mise.run | sh && export PATH="$HOME/.local/bin:$PATH" &&
  mise bootstrap --from /src --yes && exec bash -l'
```
