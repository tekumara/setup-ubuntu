#!/usr/bin/env bash

set -euo pipefail

# add docker stable repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
source /etc/os-release
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $VERSION_CODENAME stable" > "/etc/apt/sources.list.d/docker-stable-$VERSION_CODENAME.list"
apt-get update

apt-get install -y --no-install-recommends docker-ce docker-ce-cli containerd.io

# docker compose
v=v2.0.1
curl -fsSLo /usr/local/bin/docker-compose "https://github.com/docker/compose/releases/download/$v/docker-compose-linux-x86_64"
echo "b2aabbc04768efb0dc73c14d105781dd0aceb7a801d3a27d5113ad8e222f0395  /usr/local/bin/docker-compose"  | sha256sum --check
chmod a+x /usr/local/bin/docker-compose
