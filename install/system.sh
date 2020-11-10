#!/usr/bin/env bash

set -euo pipefail

set -x

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -f upgrade

# software-properties-common contains add-apt-repository and installs python
# bsdmainutils contains column
# net-tools contains ifconfig
# iputils-ping contains ping
sudo apt-get install -y sysstat software-properties-common bsdmainutils jq net-tools iputils-ping
