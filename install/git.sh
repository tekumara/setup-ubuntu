#!/usr/bin/env bash

set -euo pipefail

# brew needs git, install the latest version which allows configuring the default branch as main
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get install -y git
