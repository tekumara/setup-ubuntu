#!/usr/bin/env bash

set -euo pipefail

set -x

## allow the user running this script to use docker without sudo
sudo usermod -aG docker "$(whoami)"

## set their shell to zsh
sudo chsh -s "$(which zsh)" "$(whoami)"

# setup standard directory structure
mkdir ~/code
mkdir ~/data

#echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc

#echo 'gitauthor-status' >> ~/.bashrc

##ZSH
