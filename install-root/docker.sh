#!/usr/bin/env bash
# shellcheck disable=SC2174,SC1091

set -euo pipefail

# add docker stable repo
mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --yes --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list

apt-get update

apt-get install -y --no-install-recommends docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# enable usages of standalone "docker-compose" by linking to the plugin
[[ -f /usr/local/bin/docker-compose ]] || ln -s /usr/libexec/docker/cli-plugins/docker-compose /usr/local/bin/docker-compose
