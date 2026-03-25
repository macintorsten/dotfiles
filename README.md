# Dotfiles

Configs managed with [GNU Stow](https://www.gnu.org/software/stow/). CLI tools managed with [aqua](https://aquaproj.github.io/).

## Setup

```bash
git clone https://github.com/macintorsten/dotfiles.git ~/.dotfiles
bash ~/.dotfiles/bootstrap.sh
cd ~/.dotfiles && stow */
source ~/.bashrc
```

## Tools

Tools are defined in `aqua/.config/aquaproj-aqua/aqua.yaml`. Packages tagged `default` are installed by `bootstrap.sh`. Untagged packages are installed lazily on first use, or manually:

```bash
aqua install <owner/repo>   # install a specific package
aqua install --all          # install everything
```

## Update tools

```bash
aqua update           # bump versions in aqua.yaml
aqua install --all    # download and install updated versions
```

## Test

```bash
./test.sh      # build Docker image
./test.sh -i   # interactive shell
```