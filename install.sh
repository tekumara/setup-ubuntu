#!/usr/bin/env bash

set -uoe pipefail

URL="https://github.com/tekumara/setup-ubuntu/archive/0.1.0.tar.gz"

if ! curl --progress-bar --fail -L "$URL" -o "/tmp/setup-ubuntu.tar.gz"; then
    echo "Download failed.  Check that the release/filename are correct."
    exit 1
fi

tar -xvf /tmp/setup-ubuntu.tar.gz -C /tmp

set -x

/tmp/setup-ubuntu/system.sh
/tmp/setup-ubuntu/cuda.sh
