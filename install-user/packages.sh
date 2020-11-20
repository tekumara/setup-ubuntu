#!/usr/bin/env bash

set -euo pipefail

set -x

# install python packages
pipx install virtualenvwrapper
pipx install nbstripout
pipx install nbdime

# install fzf for fuzzy history and directory search
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
