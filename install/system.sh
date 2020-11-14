#!/usr/bin/env bash

set -euo pipefail

set -x

apt-get update
apt-get -y -f upgrade

# software-properties-common contains add-apt-repository and installs python
# gnupg2 & ca-certificates needed to add third party repos
apt-get install -y --no-install-recommends \
    gnupg2 ca-certificates software-properties-common
