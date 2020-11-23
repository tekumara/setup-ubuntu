#!/usr/bin/env bash

set -euo pipefail

curl -sL https://deb.nodesource.com/setup_lts.x | bash -
apt-get install -y nodejs
