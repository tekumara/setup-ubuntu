#!/usr/bin/env bash

set -euo pipefail

# install the latest version which allows configuring the default branch as main
apt-key adv --keyserver keyserver.ubuntu.com --recv-key E1DF1F24
source /etc/os-release
echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu $VERSION_CODENAME main" > "/etc/apt/sources.list.d/git-core-ubuntu-ppa-$VERSION_CODENAME.list"
apt-get update

sudo apt-get install -y git
