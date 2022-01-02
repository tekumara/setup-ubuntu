FROM ubuntu:20.04

# fetch package lists
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update

# enable installation of man pages & reinstall coreutils so
# we have manpages for ls etc.
RUN rm -f /etc/dpkg/dpkg.cfg.d/excludes
RUN apt-get install --reinstall -y coreutils

# setup sudo and ubuntu user with sudo rights and no password
RUN apt-get install -y sudo
RUN adduser --disabled-password --gecos '' ubuntu && adduser ubuntu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ubuntu
WORKDIR /home/ubuntu

# don't leave the locale as POSIX, otherwise we get the dreaded UnicodeDecodeError
ENV LANG=C.UTF-8

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

COPY install-user/packages.sh /tmp/install-user/
RUN /tmp/install-user/packages.sh

COPY dotfiles/ /tmp/dotfiles/

COPY install-user/config.sh /tmp/install-user/
RUN /tmp/install-user/config.sh

ENTRYPOINT [ "/usr/bin/zsh" ]
