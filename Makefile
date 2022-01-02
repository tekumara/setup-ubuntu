MAKEFLAGS += --warn-undefined-variables
SHELL = /bin/bash -o pipefail
.DEFAULT_GOAL := help
.PHONY: help build-dev-image run-dev build build-base-image test test-as-root

## display help message
help:
	@awk '/^##.*$$/,/^[~\/\.0-9a-zA-Z_-]+:/' $(MAKEFILE_LIST) | awk '!(NR%2){print $$0p}{p=$$0}' | awk 'BEGIN {FS = ":.*?##"}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' | sort

build-dev-image:
	docker-compose build dev

## run the dev docker image
run-dev: build-dev-image
	docker-compose run --rm dev

build-base-image:
	docker-compose build base

## test installer
test: build build-base-image
	docker-compose run --rm base -c "cat install.sh | bash"

## test installer as root
test-as-root: build build-base-image
	docker-compose run --rm --user root base -c "cat install.sh | bash -s -- -u ubuntu"
