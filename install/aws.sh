#!/usr/bin/env bash

set -euo pipefail

echo "Downloading awscliv2"
curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
unzip -qo /tmp/awscliv2.zip -d /tmp/
/tmp/aws/install --update
