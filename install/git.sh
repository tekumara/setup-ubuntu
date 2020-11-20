#!/usr/bin/env bash

set -euo pipefail

# add repo for the latest version of git which allows configuring the default branch as main
apt-key adv --keyserver keyserver.ubuntu.com --recv-key E1DF1F24
source /etc/os-release
echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu $VERSION_CODENAME main" > "/etc/apt/sources.list.d/git-core-ubuntu-ppa-$VERSION_CODENAME.list"
apt-get update

# add diff-so-fancy repo
apt-key adv --keyserver keyserver.ubuntu.com --recv-key 8486162E
source /etc/os-release
echo "deb http://ppa.launchpad.net/aos1/diff-so-fancy/ubuntu/ $VERSION_CODENAME main" > "/etc/apt/sources.list.d/aos1-ubuntu-diff-so-fancy-$VERSION_CODENAME.list"
apt-get update

apt-get install -y --no-install-recommends git diff-so-fancy

# install scmpuff
scmpuff_version=0.3.0
curl -fsSLo scmpuff.tar.gz "https://github.com/mroth/scmpuff/releases/download/v${scmpuff_version}/scmpuff_${scmpuff_version}_linux_x64.tar.gz"
tar -zxf scmpuff.tar.gz -C /tmp
rm scmpuff.tar.gz
install /tmp/scmpuff /usr/local/bin
