FROM ubuntu:18.04

# setup sudo and ubuntu user with sudo rights and no password
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y sudo
RUN adduser --disabled-password --gecos '' ubuntu && adduser ubuntu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ubuntu
WORKDIR /home/ubuntu

# don't leave the locale as POSIX, otherwise we get the dreaded UnicodeDecodeError
ENV LANG=C.UTF-8
