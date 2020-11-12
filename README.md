# ubuntu 18.04 install scripts

Includes:

- CUDA install scripts for Ubuntu adapted from [nvidia/container-images/cuda](https://gitlab.com/nvidia/container-images/cuda/-/tree/master/dist/10.1/ubuntu18.04-x86_64)

## Usage

```
sudo apt-get update && sudo apt-get install -y sudo curl
curl -fsSL https://raw.githubusercontent.com/tekumara/setup-ubuntu/main/install.sh | sudo bash
```

To download and extract the scripts without running them:

```
curl -fsSL https://raw.githubusercontent.com/tekumara/setup-ubuntu/main/install.sh | sudo bash -s -- --skip-install
```

## Development

A Dockerfile is provided to test the scripts. run `make` to see options for building and running the Dockerfile. 
