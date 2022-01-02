#!/usr/bin/env bash

set -euo pipefail

set -x

apt-get update

# gnupg2 is needed to add third party repos
# automake libtool make build-essential are build tools
# bsdmainutils contains column
# net-tools contains ifconfig
# iputils-ping contains ping
# ca-certificates is needed for HTTPS
apt-get install -y --no-install-recommends \
    gnupg2 \
    automake libtool make build-essential \
    sysstat net-tools iputils-ping \
    wget curl ca-certificates \
    less vim bsdmainutils jq man-db \
    zsh unzip

# install zsh plugin manager (antibody)
curl -sSfL git.io/antibody | sh -s - -b /usr/local/bin

# set default editor to vim instead of nano
update-alternatives --set editor /usr/bin/vim.basic
