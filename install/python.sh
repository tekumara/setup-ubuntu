#!/usr/bin/env bash

set -euo pipefail

# add deadsnakes ppa because it has the latest minor versions
add-apt-repository ppa:deadsnakes/ppa

apt-get install -y python3.7 python3.7-dev python3.7-venv

# create a symlink in /usr/local/bin which will take precedence on the path
ln -s /usr/bin/python3.7 /usr/local/bin/python3
ln -s /usr/bin/python3.7 /usr/local/bin/python

# install pip directly, rather than installing the deb package which depends on the older python3 package
# use sudo to make sure it is installed into dist-packages (ie: /usr/local/lib/python3.7/dist-packages/)
curl -s https://bootstrap.pypa.io/get-pip.py | sudo -H /usr/bin/python3.7

# TODO: remove _/usr/lib/python3/dist-packages_ from PYTHONPATH
