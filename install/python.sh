#!/usr/bin/env bash

set -euo pipefail
set -x
# use deadsnakes ppa rather than the ubuntu packages because it has the latest minor versions
# builds with --enable-optimizations (NB: building from source with optimizations takes a long time)
# deb packages are built with --prefix=/usr
apt-key adv --keyserver keyserver.ubuntu.com --recv-key 6A755776
source /etc/os-release
echo "deb http://ppa.launchpad.net/deadsnakes/ppa/ubuntu $VERSION_CODENAME main" > "/etc/apt/sources.list.d/deadsnakes-ubuntu-ppa-$VERSION_CODENAME.list"
apt-get update

apt-get install -y --no-install-recommends python3.7 python3.7-dev python3.7-venv

# the deadsnakes & ubuntu deb packages contain a patched version of site.py which adds /usr/lib/python3/dist-packages to PYTHONPATH
# see https://github.com/deadsnakes/python3.7/blob/4dc651768517acccad5f5081fff2de3e4d5900cd/debian/patches/distutils-install-layout.diff#L243
# this means any python3-* package installed via apt will end up in /usr/lib/python3/dist-packages and so on our PYTHONPATH
# we want an isolated version without this, so create a parallel version in /usr/local with the unpatched libs

# install the unpatched source libs into /usr/local
PYTHON_VERSION=3.7.9
wget -q -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz"
mkdir -p /usr/src/python
tar -xJC /usr/src/python --strip-components=1 -f python.tar.xz
cp -r /usr/src/python/Lib/* /usr/local/lib/python3.7/
rm python.tar.xz
rm -rf /usr/src/python
# remove empty dist-packages dir
rm -rf /usr/local/lib/python3.7/dist-packages

# copy built artifacts to /usr/local
mkdir /usr/local/lib/python3.7/lib-dynload/
cp /usr/lib/python3.7/lib-dynload/* /usr/local/lib/python3.7/lib-dynload/
cp /usr/lib/python3.7/_sysconfigdata_m_linux_x86_64-linux-gnu.py /usr/local/lib/python3.7/
# copy the binary, which sets the prefix as /usr/local
cp /usr/bin/python3.7 /usr/local/bin/python3.7

# convenience symlinks
[[ ! -f /usr/local/bin/python ]] && (cd /usr/local/bin && ln -s python3.7 python)
[[ ! -f /usr/local/bin/python3 ]] && (cd /usr/local/bin && ln -s python3.7 python3)

# install pip directly, rather than installing the deb package which depends on the older python3 package
# use sudo to make sure it is installed as a system rather than user package (ie: /usr/local/lib/python3.7/site-packages/)
curl -s https://bootstrap.pypa.io/get-pip.py | sudo -H /usr/local/bin/python3
