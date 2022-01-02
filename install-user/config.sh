#!/usr/bin/env bash

set -euo pipefail

set -x

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

## allow the user running this script to use docker without sudo
sudo usermod -aG docker "$(whoami)"

## set their shell to zsh
sudo chsh -s "$(which zsh)" "$(whoami)"

# setup standard directory structure
mkdir -p ~/code
mkdir -p ~/data

# install dotfiles
cp -r "$DIR"/../dotfiles/. ~

# run zsh to start antibody for the first time to download plugins
zsh -c "source ~/.zshrc"
