SHELL:=/usr/bin/env bash -euo pipefail -c
NAME:=$(shell basename "$(shell pwd)")
LABEL:=$(NAME):latest

main:
	echo $(LABEL)
	@>&2 echo "no supported default option"; false

build:
	# https://www.docker.com/blog/introduction-to-heredocs-in-dockerfiles/
	# https://www.stereolabs.com/docs/docker/building-arm-container-on-x86/
	DOCKER_BUILDKIT=1 \
		docker build \
		--file "Dockerfile" \
		--tag "$(LABEL)" \
		--progress=plain \
		.

run: build
	docker run \
		--interactive \
		--tty \
		--rm \
		--env GITHUB_OUTPUT=/tmp/GITHUB_OUTPUT \
		"$(NAME)"

shell: build
	docker run \
		--interactive \
		--tty \
		--rm \
		--env GITHUB_OUTPUT=/tmp/GITHUB_OUTPUT \
		--entrypoint "" \
		"$(NAME)" \
		/bin/sh

.PHONY: main build run shell
