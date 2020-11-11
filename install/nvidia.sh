#!/usr/bin/env bash

set -euo pipefail

# add nvidia repos
curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub | apt-key add - && \
echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list && \
echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list
apt-get update

# install nvidia drivers
apt-get install -y --no-install-recommends cuda-drivers

# test
nvidia-smi

# install the Nvidia Container Toolkit to allow Docker to use GPUs
curl -fsSL https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | tee /etc/apt/sources.list.d/nvidia-docker.list
apt-get update

apt-get install -y --no-install-recommends nvidia-container-toolkit

systemctl restart docker

## test

nvidia-container-cli -k -d /dev/tty info
