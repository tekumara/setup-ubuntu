#!/usr/bin/env bash

set -euo pipefail

set -x

apt-get update
apt-get -y -f upgrade

# gnupg2 is needed to add third party repos
# automake libtool make build-essential are build tools
# bsdmainutils contains column
# net-tools contains ifconfig
# iputils-ping contains ping
apt-get install -y --no-install-recommends \
    gnupg2 \
    automake libtool make build-essential \
    less vim bsdmainutils jq man-db sysstat net-tools iputils-ping
    