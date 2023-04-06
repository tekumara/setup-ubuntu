#!/usr/bin/env bash

set -euo pipefail

# use deadsnakes ppa rather than the ubuntu packages because it has the latest minor versions
# and builds with --enable-optimizations (vs. building from source with optimizations which takes a long time)
# NB: deb packages are built with --prefix=/usr
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key 6A755776
source /etc/os-release
echo "deb http://ppa.launchpad.net/deadsnakes/ppa/ubuntu $VERSION_CODENAME main" > "/etc/apt/sources.list.d/deadsnakes-ubuntu-ppa-$VERSION_CODENAME.list"
apt-get update

DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends python3.9 python3.9-dev python3.9-venv python3-apt

# create symlinks in /usr/local/bin which will take precedence on the path
[[ ! -f /usr/local/bin/python3 ]] && ln -s /usr/bin/python3.10 /usr/local/bin/python3
[[ ! -f /usr/local/bin/python ]] && ln -s /usr/bin/python3.10 /usr/local/bin/python

# allow apt_pkg to be used by python minor versions other than the python3-apt build version
[[ ! -f /usr/lib/python3/dist-packages/apt_pkg.so ]] && ln -s /usr/lib/python3/dist-packages/apt_pkg.cpython-*.so /usr/lib/python3/dist-packages/apt_pkg.so

# install pip and packages as root to make available system-wide in /usr/local/lib/python3.9/dist-packages/

# install pip directly, rather than installing the deb package which depends on the older python3 package
curl -fsSL https://bootstrap.pypa.io/get-pip.py | /usr/local/bin/python3

pip install --no-cache-dir pipx

# virtualenv is used by virtualenvwrapper
pip install --no-cache-dir virtualenv
