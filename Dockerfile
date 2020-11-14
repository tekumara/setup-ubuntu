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

COPY install/python.sh /tmp/install/
RUN sudo /tmp/install/python.sh

COPY install/nvidia-drivers.sh /tmp/install/
RUN sudo /tmp/install/nvidia-drivers.sh

COPY install/nvidia-docker.sh /tmp/install/
RUN sudo /tmp/install/nvidia-docker.sh

COPY install/cuda.sh /tmp/install/
RUN sudo /tmp/install/cuda.sh

COPY install/git.sh /tmp/install/
RUN sudo /tmp/install/git.sh

# brew cannot be installed as root, so don't use sudo
COPY install/brew.sh /tmp/install/
RUN /tmp/install/brew.sh
