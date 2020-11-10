#!/usr/bin/env bash

set -euo pipefail

# add deadsnakes ppa because it has the latest minor versions
add-apt-repository ppa:deadsnakes/ppa

apt-get install -y python3.7 python3.7-dev python3.7-venv

# create a symlink in /usr/local/bin which will take precedence on the path
ln -s /usr/bin/python3.7 /usr/local/bin/python3
