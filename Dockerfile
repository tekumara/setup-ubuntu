FROM ubuntu:24.04 as base

# fetch package lists
ENV DEBIAN_FRONTEND noninteractive

# install curl (used by install.sh)
RUN apt-get update && apt-get install -y curl

# setup sudo and ubuntu user with sudo rights and no password
RUN apt-get install -y --no-install-recommends sudo
RUN adduser --disabled-password --gecos '' ubuntu && adduser ubuntu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ubuntu
WORKDIR /home/ubuntu

# don't leave the locale as POSIX, otherwise we get the dreaded UnicodeDecodeError
ENV LANG=C.UTF-8

ENTRYPOINT [ "/bin/bash" ]

# development docker image
# use this to develop the scripts locally, as opposed to having to work remotely or in a VM.
# each script creates a new image layer which docker caches; this makes it easy to iterate on changes.
FROM base as dev

# enable installation of man pages & reinstall coreutils so
# we have manpages for ls etc.
RUN sudo rm -f /etc/dpkg/dpkg.cfg.d/excludes && sudo apt-get install --reinstall -y coreutils

# copy and run files one at a time to create individual caching layers
COPY install-root/system.sh /tmp/install-root/
RUN sudo /tmp/install-root/system.sh

COPY install-root/docker.sh /tmp/install-root/
RUN sudo /tmp/install-root/docker.sh

COPY install-root/git.sh /tmp/install-root/
RUN sudo /tmp/install-root/git.sh

COPY install-root/python.sh /tmp/install-root/
RUN sudo /tmp/install-root/python.sh

COPY install-root/java.sh /tmp/install-root/
RUN sudo /tmp/install-root/java.sh

COPY install-root/node.sh /tmp/install-root/
RUN sudo /tmp/install-root/node.sh

COPY install-root/aws.sh /tmp/install-root/
RUN sudo /tmp/install-root/aws.sh

COPY install-root/ripgrep.sh /tmp/install-root/
RUN sudo /tmp/install-root/ripgrep.sh

COPY install-root/kubes.sh /tmp/install-root/
RUN sudo /tmp/install-root/kubes.sh

COPY install-user/packages.sh /tmp/install-user/
RUN /tmp/install-user/packages.sh

COPY dotfiles/ /tmp/dotfiles/

COPY install-user/config.sh /tmp/install-user/
RUN /tmp/install-user/config.sh

ENTRYPOINT [ "/usr/bin/zsh" ]
