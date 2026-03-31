# AI Agent Guide

## Structure

Each tool has its own directory at repo root — a stow package. `stow */` from `~/.dotfiles` deploys all configs to `~` by default.

Shell integrations live in `bash/.config/bashrc.d/##-<tool>.sh`. CLI tools are managed via `mise/.config/mise/config.toml`, while `bootstrap.sh` installs rootless prerequisites like `mise` itself.

## Workflow

```bash
bash ~/.dotfiles/bootstrap.sh   # install tools (idempotent)
cd ~/.dotfiles && stow */        # deploy configs
source ~/.bashrc
```

## Adding a tool

1. Create `<tool>/` with stow-compatible structure (`<tool>/.config/...` or `<tool>/.<tool>rc`)
2. If shell integration needed: add `bash/.config/bashrc.d/##-<tool>.sh`
3. If managed by mise: add to `mise/.config/mise/config.toml`
4. If the tool still needs custom bootstrap logic: add it to `bootstrap.sh` without requiring root

## Removing a tool

1. Delete `<tool>/`
2. Delete `bash/.config/bashrc.d/##-<tool>.sh` (if exists)
3. Remove from `config.toml` or `bootstrap.sh`

## bashrc.d numbering

- `00-` PATH/environment
- `05-` tool managers
- `50-` prompt/init
- `60-70` tool integrations

## Testing

```bash
./test.sh      # build Docker image
./test.sh -i   # interactive shell
```
