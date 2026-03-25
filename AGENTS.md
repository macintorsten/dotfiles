# AI Agent Guide

## Structure

```
~/.dotfiles/    (repo root = stow dir)
  aqua/         # aqua tool manager config
  bash/         # shell config (bashrc.d)
  bat/
  oh-my-posh/
  tmux/
  vim/
  bootstrap.sh  # install tools (stow, aqua, tpm + aqua packages)
  test.sh       # Docker build test
```

## Workflow

```bash
bash ~/.dotfiles/bootstrap.sh   # install tools (idempotent)
cd ~/.dotfiles && stow */        # deploy configs (targets ~ by default)
source ~/.bashrc
```

## Adding a tool

1. Create `<tool>/` at repo root with stow-compatible structure
2. If shell integration needed: add `bash/.config/bashrc.d/##-<tool>.sh`
3. If managed by aqua: add to `aqua/.config/aquaproj-aqua/aqua.yaml`
4. If binary not in aqua registry: add install to `bootstrap.sh`

## Removing a tool

1. Delete `<tool>/`
2. Delete `bash/.config/bashrc.d/##-<tool>.sh` (if exists)
3. Remove from `aqua.yaml` or `bootstrap.sh` as appropriate

## Stow structure

- `<tool>/.config/file` → `~/.config/file`
- `<tool>/.<tool>rc` → `~/.<tool>rc`

`stow */` from `~/.dotfiles` targets `~` by default — no `-t ~` needed.

## bashrc.d numbering

- `00-` PATH/environment
- `05-` tool managers (aqua)
- `50-` prompt/init
- `60-70` tool integrations

## Testing

```bash
./test.sh      # build Docker image
./test.sh -i   # interactive shell
```
