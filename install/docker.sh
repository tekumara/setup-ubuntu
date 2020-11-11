#!/usr/bin/env bash

set -euo pipefail

# add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# add stable repo
add-apt-repository -y \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get install -y --no-install-recommends docker-ce docker-ce-cli containerd.io
