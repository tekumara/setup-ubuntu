# ubuntu install scripts

[![Build](https://github.com/tekumara/setup-ubuntu/actions/workflows/ci.yml/badge.svg)](https://github.com/tekumara/setup-ubuntu/actions/workflows/ci.yml)

Includes:

- docker
- python 3.9 + [pipx](https://github.com/pipxproject/pipx) + [virtualenvwrapper](https://virtualenvwrapper.readthedocs.io/en/latest/)
- java 11
- node LTS
- git with [handy aliases](dotfiles/.zshrc.d/git.plugin.zsh) including file number shortcuts via [scmpuff](https://github.com/mroth/scmpuff#usage)
- zsh + dotfiles + [fzf](https://github.com/junegunn/fzf) + [zsh-z](https://github.com/agkozak/zsh-z)

## Prerequisites

- Ubuntu 18.04 / 20.04
- Install curl: `sudo apt-get install -y curl`

## Usage

Download, extract and run the install scripts:

```
curl -fsSL https://raw.githubusercontent.com/tekumara/setup-ubuntu/main/install.sh | bash
```

Download and extract the scripts without running them:

```
curl -fsSL https://raw.githubusercontent.com/tekumara/setup-ubuntu/main/install.sh | bash -s -- --skip-install
```

Or use [setup-ubuntu.yaml](setup-ubuntu.yaml) cloud config as your cloud-init userdata file.

## Development

Run `make` to see all options for development, test, and publish.

A development docker image is provided to help develop the scripts locally (see [Dockerfile](Dockerfile)).

The installer supports installing as root, or a user using sudo. When installed via cloud-init the installer will be running as root.

When adding ubuntu packages repos follow the [existing pattern](install-root/docker.sh). Do not install software-properties-common and use apt-add-repository. The software-properties-common package installs python3, python3-dbus, and python3-apt which adds python packages to _/usr/lib/python3/dist-packages_. Anything in _/usr/lib/python3/dist-packages_ is added to all python interpreters' PYTHONPATH. This can affect the deadsnakes version of python we install (see [python.sh](install-root/python.sh)).
