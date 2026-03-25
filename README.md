# Dotfiles

Configs managed with [GNU Stow](https://www.gnu.org/software/stow/). CLI tools managed with [aqua](https://aquaproj.github.io/).

## Setup

```bash
git clone https://github.com/macintorsten/dotfiles.git ~/.dotfiles
bash ~/.dotfiles/bootstrap.sh
cd ~/.dotfiles && stow */
source ~/.bashrc
```

## Update tools

```bash
cd ~/.dotfiles/aqua/.config/aquaproj-aqua && aqua update
```

## Test

```bash
./test.sh      # build Docker image
./test.sh -i   # interactive shell
```