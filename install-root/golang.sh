#!/usr/bin/env bash

set -euo pipefail

# add golang longsleep repo
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key 56A3D45E
source /etc/os-release
echo "deb http://ppa.launchpad.net/longsleep/golang-backports/ubuntu $VERSION_CODENAME main" > "/etc/apt/sources.list.d/longsleep-golang-backports-$VERSION_CODENAME.list"
apt-get update

apt-get install -y golang
