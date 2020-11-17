FROM ubuntu:18.04

# setup sudo and ubuntu user with sudo rights and no password
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y sudo curl
RUN adduser --disabled-password --gecos '' ubuntu && adduser ubuntu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ubuntu
WORKDIR /home/ubuntu

# don't leave the locale as POSIX, otherwise we get the dreaded UnicodeDecodeError
ENV LANG=C.UTF-8

# copy files one at a time to create individual caching layers
COPY install/system.sh /tmp/install/
RUN sudo /tmp/install/system.sh

COPY install/docker.sh /tmp/install/
RUN sudo /tmp/install/docker.sh

COPY install/git.sh /tmp/install/
RUN sudo /tmp/install/git.sh

COPY install/python.sh /tmp/install/
RUN sudo /tmp/install/python.sh

COPY install/java.sh /tmp/install/
RUN sudo /tmp/install/java.sh
