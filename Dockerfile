FROM ubuntu:18.04

# setup sudo and ubuntu user with sudo rights and no password
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y sudo curl
RUN adduser --disabled-password --gecos '' ubuntu && adduser ubuntu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ubuntu
WORKDIR /home/ubuntu

# don't leave the locale as POSIX, otherwise we get the dreaded UnicodeDecodeError
ENV LANG=C.UTF-8

# copy files one at a time to create indivual caching layers
COPY install/system.sh /tmp/install/
RUN sudo /tmp/install/system.sh

COPY install/cuda.sh /tmp/install/
RUN sudo /tmp/install/cuda.sh
