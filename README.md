# ubuntu 18.04 install scripts

Includes:

- nvidia kernel drivers + container toolkit
- CUDA install scripts adapted from [nvidia/container-images/cuda](https://gitlab.com/nvidia/container-images/cuda/-/tree/master/dist/10.1/ubuntu18.04-x86_64)
- python 3.7

## Prequisities

- Ubuntu 18.04
- Install curl: `sudo apt-get update && sudo apt-get install -y curl`

## Usage

Download, extract and run the install scripts:

```
curl -fsSL https://raw.githubusercontent.com/tekumara/setup-ubuntu/main/install.sh | sudo bash
```

Download and extract the scripts without running them:

```
curl -fsSL https://raw.githubusercontent.com/tekumara/setup-ubuntu/main/install.sh | sudo bash -s -- --skip-install
```

## Development

A Dockerfile is provided to test the scripts. run `make` to see options for building and running the Dockerfile.
