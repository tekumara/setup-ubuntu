#!/usr/bin/env bash

set -euo pipefail

set -x

## Equivalent to the nvidia/cuda:10.1-runtime-ubuntu18.04 docker image

## 10.1-base-ubuntu18.04
## see https://gitlab.com/nvidia/container-images/cuda/-/blob/master/dist/10.1/ubuntu18.04-x86_64/base/Dockerfile

# add nvidia repos
curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub | apt-key add - && \
echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list && \
echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list
apt-get update

CUDA_VERSION="10.1.243"
CUDA_PKG_VERSION="10-1=$CUDA_VERSION-1"

# For libraries in the cuda-compat-* package: https://docs.nvidia.com/cuda/eula/index.html#attachment-a
apt-get install -y --no-install-recommends \
    cuda-cudart-$CUDA_PKG_VERSION \
    cuda-compat-10-1 \
    && ln -s cuda-10.1 /usr/local/cuda10

# Required for nvidia-docker v1
echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

PATH="/usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}"
LD_LIBRARY_PATH="/usr/local/nvidia/lib:/usr/local/nvidia/lib64"

# nvidia-container-runtime
NVIDIA_VISIBLE_DEVICES="all"
NVIDIA_DRIVER_CAPABILITIES="compute,utility"
NVIDIA_REQUIRE_CUDA="cuda>=10.1 brand=tesla,driver>=396,driver<397 brand=tesla,driver>=410,driver<411 brand=tesla,driver>=418,driver<419"

## 10.1-runtime-ubuntu18.04
## see https://gitlab.com/nvidia/container-images/cuda/-/blob/master/dist/10.1/ubuntu18.04-x86_64/runtime/Dockerfile

NCCL_VERSION="2.7.8"

apt-get install -y --no-install-recommends \
    cuda-libraries-$CUDA_PKG_VERSION \
    cuda-npp-$CUDA_PKG_VERSION \
    cuda-nvtx-$CUDA_PKG_VERSION \
    libcublas10=10.2.1.243-1 \
    libnccl2=$NCCL_VERSION-1+cuda10.1 \
    && apt-mark hold libnccl2

# apt from auto upgrading the cublas package. See https://gitlab.com/nvidia/container-images/cuda/-/issues/88
apt-mark hold libcublas10

## 10.1-cudnn7-runtime-ubuntu18.04
## see https://gitlab.com/nvidia/container-images/cuda/-/blob/master/dist/10.1/ubuntu18.04-x86_64/runtime/cudnn7/Dockerfile

CUDNN_VERSION="7.6.5.32"

apt-get update && apt-get install -y --no-install-recommends \
    libcudnn7=$CUDNN_VERSION-1+cuda10.1 \
    && apt-mark hold libcudnn7

rm -rf /var/lib/apt/lists/*
