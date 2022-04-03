#!/usr/bin/env bash

set -euo pipefail

# add docker stable repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
source /etc/os-release
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $VERSION_CODENAME stable" > "/etc/apt/sources.list.d/docker-stable-$VERSION_CODENAME.list"
apt-get update

apt-get install -y --no-install-recommends docker-ce docker-ce-cli containerd.io

# docker compose
v=v2.4.0
curl -fsSLo /usr/local/bin/docker-compose "https://github.com/docker/compose/releases/download/$v/docker-compose-linux-x86_64"
echo "83527297959403d20a4fd4f00d3db6d9bbbc0cc5704787ec4396cd706a6c8bb4  /usr/local/bin/docker-compose"  | sha256sum --check
chmod a+x /usr/local/bin/docker-compose
# integrate into the docker cli as `docker compose`
ln -s /usr/local/bin/docker-compose /usr/libexec/docker/cli-plugins/docker-compose
