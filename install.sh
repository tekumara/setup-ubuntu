#!/usr/bin/env bash

set -uoe pipefail

TARBALL_URL=$(curl -s https://api.github.com/repos/tekumara/setup-ubuntu/releases/latest | grep tarball | cut -d '"' -f 4)

if ! curl --progress-bar --fail -L "$TARBALL_URL" -o "/tmp/setup-ubuntu.tar.gz"; then
    echo "Download failed.  Check that the release/filename are correct."
    exit 1
fi

tar -xvf /tmp/setup-ubuntu.tar.gz -C /tmp --strip-components=1

set -x

export DEBIAN_FRONTEND=noninteractive
/tmp/install/system.sh
/tmp/install/cuda.sh
