# Dotfiles

My dotfiles and CLI tools, managed by [mise](https://mise.jdx.dev/) (`mise bootstrap` + `mise dotfiles`). Requires mise 2026.10.4+.

## Setup

Prerequisites: `git`, `curl`, and `sudo` (unless root) for the `apt:` packages on Debian/Ubuntu.

```bash
curl -fsSL https://mise.run | sh
~/.local/bin/mise bootstrap --from https://github.com/macintorsten/dotfiles.git
```

Open a new shell afterwards. If GitHub rate-limits tool downloads, set `MISE_GITHUB_TOKEN` first.

`--from` clones the repo to `~/.local/share/mise/bootstrap-repo` and applies [`mise.toml`](mise.toml). Dotfiles are symlinks into that checkout, so edit them in place.

## Dotfiles approach

The recommended [mise setup](https://mise.jdx.dev/dotfiles.html#recommended-setup) tracks files where they already live, saves their history with a watcher, and can sync through a private repository. This repo intentionally uses the other supported approach: configuration is maintained here and deployed as symlinks by `mise bootstrap`. That makes the checkout the source of truth, so the history watcher, `mise dot origin`, and `mise bootstrap --adopt` workflow are not part of this setup. See [Set up a machine](https://mise.jdx.dev/bootstrap/setup.html) for the tracking-and-sync workflow.

To replace existing files that conflict with a dotfile, add `--force-dotfiles`:

```bash
~/.local/bin/mise bootstrap --from https://github.com/macintorsten/dotfiles.git --force-dotfiles
```

## Layout

- [`mise.toml`](mise.toml): machine setup (project config, used from the checkout): apt packages, git repos, shell integration, and hooks. Tasks live in [`mise-tasks/`](mise-tasks).
- [`home/`](home): mirrors `$HOME`; every file is symlinked into place.
- [`home/.config/mise/config.toml`](home/.config/mise/config.toml): the global tools, locked in [`mise.lock`](home/.config/mise/mise.lock).

## Daily use

```bash
mise bootstrap --from https://github.com/macintorsten/dotfiles.git --update   # pull and re-apply

# these need the project config, so run them in the checkout
cd ~/.local/share/mise/bootstrap-repo
mise bootstrap status         # tools, packages, shell
mise dot status               # dotfiles
mise dot add --group home ~/.config/foo/bar   # move an existing file into home/ and link it back
```

After editing tools, refresh the lockfile and commit it:

```bash
mise lock --global --platform linux-x64,linux-arm64,macos-arm64
```

## Test

Needs Docker. The [`test`](mise-tasks/test) task bootstraps the committed `HEAD` of your local checkout in a clean Ubuntu container, then drops you into a shell. Downloads are cached in the `dotfiles-test-cache` volume.

```bash
mise run test
```
