# ubuntu 18.04 install scripts

Includes:

- docker
- python 3.7
- git

## Prerequisites

- Ubuntu 18.04
- Install curl: `sudo apt-get install -y curl`

## Usage

Download, extract and run the install scripts:

```
curl -fsSL https://raw.githubusercontent.com/tekumara/setup-ubuntu/main/install.sh | bash
```

Download and extract the scripts without running them:

```
curl -fsSL https://raw.githubusercontent.com/tekumara/setup-ubuntu/main/install.sh | bash -s -- --skip-install
```

## Development

A Dockerfile is provided to test the scripts. run `make` to see options for building and running the Dockerfile.
