#!/usr/bin/env bash

set -euo pipefail

# add docker stable repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
source /etc/os-release
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $VERSION_CODENAME stable" > "/etc/apt/sources.list.d/docker-stable-$VERSION_CODENAME.list"
apt-get update

apt-get install -y --no-install-recommends docker-ce docker-ce-cli containerd.io
