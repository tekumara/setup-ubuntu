#!/usr/bin/env bash

set -euo pipefail

set -x

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -y -f upgrade

# software-properties-common contains add-apt-repository and installs python
# bsdmainutils contains column
# net-tools contains ifconfig
# iputils-ping contains ping
# gnupg2 & ca-certificates needed for repos
apt-get install -y --no-install-recommends sysstat bsdmainutils jq net-tools iputils-ping curl \
    gnupg2 ca-certificates software-properties-common
