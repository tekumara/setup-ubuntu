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
            shift
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

tarball_url="https://github.com/qthurier/setup-ubuntu/tarball/$GIT_SHA"
echo "Downloading $tarball_url"
if ! curl --progress-bar --fail -L "$tarball_url" -o "/tmp/setup-ubuntu.tar.gz"; then
    die "Download failed.  Check that the URL is correct."
fi

dir=/tmp/setup-ubuntu
mkdir -p $dir

echo "Extracting install scripts to $dir"
tar -xvf /tmp/setup-ubuntu.tar.gz -C $dir --strip-components=1

if [[ "$INSTALL" = false ]]; then
    echo "Skipping install"
else
    set -x

    export DEBIAN_FRONTEND=noninteractive
    sudo $dir/install-root/system.sh
    sudo $dir/install-root/docker.sh
    sudo $dir/install-root/git.sh
    sudo $dir/install-root/python.sh
    sudo $dir/install-root/java.sh
    sudo $dir/install-root/node.sh
    sudo $dir/install-root/aws.sh
	sudo $dir/install-root/ripgrep.sh
    if [[ "$USER" == "root" ]]; then
        sudo -H -u "$INSTALL_USER" $dir/install-user/packages.sh
        sudo -H -u "$INSTALL_USER" $dir/install-user/config.sh
    else
        $dir/install-user/packages.sh
        $dir/install-user/config.sh
    fi
    echo "Done ✨. Relogin to start using zsh."
fi
