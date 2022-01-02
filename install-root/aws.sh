#!/usr/bin/env bash

set -euo pipefail

echo "Install awscli v2"

tmp_dir=$(mktemp -d) && pushd "$tmp_dir"
curl -fsSLo awscliv2.zip "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
echo "c8585e208a05ac1531083ff206591cee7d299a6924c171ad1e71a61a7dc2f55a  awscliv2.zip"
unzip -qo awscliv2.zip
./aws/install --update
popd && rm -rf "$tmp_dir"
