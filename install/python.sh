#!/usr/bin/env bash

set -euo pipefail

# use deadsnakes ppa rather than the ubuntu packages because it has the latest minor versions
# builds with --enable-optimizations (NB: building from source with optimizations takes a long time)
apt-key adv --keyserver keyserver.ubuntu.com --recv-key 6A755776
source /etc/os-release
echo "deb http://ppa.launchpad.net/deadsnakes/ppa/ubuntu $VERSION_CODENAME main" > "/etc/apt/sources.list.d/deadsnakes-ubuntu-ppa-$VERSION_CODENAME.list"
apt-get update

apt-get install -y --no-install-recommends python3.7 python3.7-dev python3.7-venv

# create a symlink in /usr/local/bin which will take precedence on the path
[[ ! -f /usr/local/bin/python3 ]] && ln -s /usr/bin/python3.7 /usr/local/bin/python3
[[ ! -f /usr/local/bin/python ]] && ln -s /usr/bin/python3.7 /usr/local/bin/python

# install pip directly, rather than installing the deb package which depends on the older python3 package
# use sudo to make sure it is installed into dist-packages (ie: /usr/local/lib/python3.7/dist-packages/)
curl -s https://bootstrap.pypa.io/get-pip.py | sudo -H /usr/bin/python3.7

# NB:
# the .deb contains a modified version of site.py which adds /usr/lib/python3/dist-packages to PYTHONPATH
# See https://github.com/deadsnakes/python3.7/blob/4dc651768517acccad5f5081fff2de3e4d5900cd/debian/patches/distutils-install-layout.diff#L243
# Any python3-* .deb package will install into /usr/lib/python3/dist-packages which means they'll appear on the PYTHONPATH of this version
# so it's not completely isolated
