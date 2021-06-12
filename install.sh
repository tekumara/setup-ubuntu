#!/usr/bin/env bash

set -uoe pipefail

INSTALL=true
GIT_SHA=main

function die() {
    echo >&2 -e ERROR: "$@"
    exit 1
}

parse_args() {
    while [[ $# -gt 0 ]]; do
        key="$1"

        case $key in
        -s | --skip-install)
            INSTALL=false
            shift # next argument
            ;;
        -u | --install-user)
            shift
            INSTALL_USER="$1"
            shift
            ;;
        -g | --git-sha)
            GIT_SHA="$1"
            shift
            ;;
        *)
            echo "Unrecognized argument $key"
            exit 1
            ;;
        esac
    done
}

parse_args "$@"

USER=$(whoami)

if [[ "$USER" == "root" && -z "${INSTALL_USER-}" ]]; then
    die "When run as root must specify an install user via -u"
fi

if ! curl --progress-bar --fail -L "https://github.com/tekumara/setup-ubuntu/tarball/$GIT_SHA" -o "/tmp/setup-ubuntu.tar.gz"; then
    die "Download failed.  Check that the release/filename are correct."
fi

echo "Extracting install scripts to /tmp/"
tar -xvf /tmp/setup-ubuntu.tar.gz -C /tmp --strip-components=1

if [[ "$INSTALL" = false ]]; then
    echo "Skipping install"
else
    set -x

    export DEBIAN_FRONTEND=noninteractive
    sudo /tmp/install-root/system.sh
    sudo /tmp/install-root/docker.sh
    sudo /tmp/install-root/git.sh
    sudo /tmp/install-root/python.sh
    sudo /tmp/install-root/java.sh
    sudo /tmp/install-root/node.sh
    sudo /tmp/install-root/aws.sh
    if [[ "$USER" == "root" ]]; then
        sudo -H -u "$INSTALL_USER" /tmp/install-user/packages.sh
        sudo -H -u "$INSTALL_USER" /tmp/install-user/config.sh
    else
        /tmp/install-user/packages.sh
        /tmp/install-user/config.sh
    fi
    echo "Done ✨. Relogin to start using zsh."
fi
