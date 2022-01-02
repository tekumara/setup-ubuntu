#!/usr/bin/env bash

set -euo pipefail

v=13.0.0
echo "Install ripgrep $v"

curl -fsSLo /tmp/ripgrep.deb "https://github.com/BurntSushi/ripgrep/releases/download/${v}/ripgrep_${v}_amd64.deb"
echo "6d78bed13722019cb4f9d0cf366715e2dcd589f4cf91897efb28216a6bb319f1  /tmp/ripgrep.deb"  | sha256sum --check
dpkg -i /tmp/ripgrep.deb
rm /tmp/ripgrep.deb
