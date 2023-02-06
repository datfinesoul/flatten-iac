SHELL:=/usr/bin/env bash -euo pipefail -c
NAME:=$(shell basename "$(shell pwd)")
LABEL:=$(NAME):latest

main:
	echo $(LABEL)
	@>&2 echo "no supported default option"; false

build:
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
		"$(NAME)" \
		1.3.7

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
