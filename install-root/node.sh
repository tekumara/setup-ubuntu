#!/usr/bin/env bash

set -euo pipefail

curl -sL https://deb.nodesource.com/setup_16.x | bash -
apt-get install -y nodejs
