#!/usr/bin/env bash

set -euo pipefail

# install the Nvidia Container Toolkit to allow Docker to use GPUs
curl -fsSL https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | tee /etc/apt/sources.list.d/nvidia-docker.list
apt-get update

apt-get install -y --no-install-recommends nvidia-container-toolkit

systemctl restart docker
