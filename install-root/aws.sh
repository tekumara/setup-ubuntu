#!/usr/bin/env bash

set -euo pipefail

echo "Install awscli v2"

tmp_dir=$(mktemp -d) && pushd "$tmp_dir"
curl -fsSLo awscliv2.zip "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
unzip -qo awscliv2.zip
./aws/install --update
popd && rm -rf "$tmp_dir"
