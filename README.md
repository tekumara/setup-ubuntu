# ubuntu 18.04 install scripts

Includes:

- docker
- python 3.7
- java 1.8
- node LTS
- git
- zsh + dotfiles + [fzf](https://github.com/junegunn/fzf) + [zsh-z](https://github.com/agkozak/zsh-z)

## Prerequisites

- Ubuntu 18.04
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

## Development

[Dockerfile](Dockerfile) is provided to help build the scripts. Each layer is a script and cached to make it easy to iterate on changes.
[Dockerfile.test](Dockerfile.test) is used to run the install scripts end to end.

Run `make` to see options for building and running the Dockerfiles.

When adding ubuntu packages repos follow the [existing pattern](install/docker.sh). Do not install software-properties-common and use apt-add-repository. The software-properties-common package installs python3, python3-dbus, and python3-apt which adds python packages to _/usr/lib/python3/dist-packages_. Anything in _/usr/lib/python3/dist-packages_ is added to all python interpreters' PYTHONPATH.
