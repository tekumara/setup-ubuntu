#!/usr/bin/env bash

set -uoe pipefail

INSTALL=true

function die() {
    >&2 echo -e "$@"
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
        *)
            echo "Unrecognized argument $key"
            exit 1
            ;;
        esac
    done
}

parse_args "$@"

USER=$(whoami)

if [[ "$USER" == "root"  && -z "${INSTALL_USER-}" ]]; then
    die "When run as root must specify an install user via -u"
fi

TARBALL_URL=$(curl -fsSL https://api.github.com/repos/tekumara/setup-ubuntu/releases/latest | grep tarball | cut -d '"' -f 4)

if ! curl --progress-bar --fail -L "$TARBALL_URL" -o "/tmp/setup-ubuntu.tar.gz"; then
    echo "Download failed.  Check that the release/filename are correct."
    exit 1
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
