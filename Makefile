SHELL=/bin/bash

build:
	docker/environment.sh --up network
	docker/environment.sh --up registry
	(cd docker/images; make)
	docker/environment.sh --down registry
	docker/environment.sh --down network

.DEFAULT_GOAL := build
.PHONY: build
