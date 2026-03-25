# AI Agent Guide

## Structure

Each tool has its own directory at repo root — a stow package. `stow */` from `~/.dotfiles` deploys all configs to `~` by default.

Shell integrations live in `bash/.config/bashrc.d/##-<tool>.sh`. Tools are managed via `aqua/.config/aquaproj-aqua/aqua.yaml` or `bootstrap.sh` if not in the aqua registry.

## Workflow

```bash
bash ~/.dotfiles/bootstrap.sh   # install tools (idempotent)
cd ~/.dotfiles && stow */        # deploy configs
source ~/.bashrc
```

## Adding a tool

1. Create `<tool>/` with stow-compatible structure (`<tool>/.config/...` or `<tool>/.<tool>rc`)
2. If shell integration needed: add `bash/.config/bashrc.d/##-<tool>.sh`
3. If managed by aqua: add to `aqua/.config/aquaproj-aqua/aqua.yaml`
4. If not in aqua registry: add install to `bootstrap.sh`

## Removing a tool

1. Delete `<tool>/`
2. Delete `bash/.config/bashrc.d/##-<tool>.sh` (if exists)
3. Remove from `aqua.yaml` or `bootstrap.sh`

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
