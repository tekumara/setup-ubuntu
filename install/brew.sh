#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -uoe pipefail

sudo apt-get install -y build-essential file

# install brew
if ! hash brew; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
    echo brew update ...
    brew update
fi

#echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> /home/ubuntu/.profile
#eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
#- We recommend that you install GCC:
#    brew install gcc
