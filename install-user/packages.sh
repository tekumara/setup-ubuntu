#!/usr/bin/env bash

set -euo pipefail

set -x

# install python packages
pipx install virtualenvwrapper
pipx install nbstripout
pipx install nbdime

# install fzf for fuzzy history and directory search
if [[ ! -d "$HOME/.fzf" ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
fi
