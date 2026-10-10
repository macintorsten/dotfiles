# AI Agent Guide

Everything is managed by mise (2026.10.4+): no Stow, no bootstrap script.

## Structure

- `mise.toml` — bootstrap project: dotfile group, apt packages, git repos, bash integration, test tasks.
- `home/` — mirrors `$HOME`; every file is symlinked into place by the `home` dotfile group.
- `home/.config/mise/config.toml` — global tools (deployed to `~/.config/mise/config.toml`).
- `home/.config/bashrc.d/##-<tool>.sh` — shell integrations, sourced from the `~/.bashrc` activate block in `mise.toml` after mise activation.

## Workflow

```bash
mise bootstrap --from https://github.com/macintorsten/dotfiles.git   # first run / re-apply
mise bootstrap status --missing && mise dot status                   # verify (inside the checkout)
```

## Adding a tool

1. Global CLI tool: add it to `home/.config/mise/config.toml`.
2. Its config: add files under `home/` at their `$HOME` path (no `mise.toml` change needed).
3. Shell integration: add `home/.config/bashrc.d/##-<tool>.sh`.
4. System package or git checkout: add to `[bootstrap.packages]` / `[bootstrap.repos]` in `mise.toml`.

## Removing a tool

Delete its files from `home/`, then `mise dot apply --prune`. Remove its entries from the config files above.

## bashrc.d numbering

- `01-` environment
- `50-` prompt/init
- `60-70` tool integrations

## Testing

```bash
mise run test         # clean Ubuntu container: bootstrap + status check
mise run test:shell   # interactive login shell in that image
```
