SHELL=/bin/bash

REGISTRY ?= localhost:5000
IMAGE ?=datalabframework
TAG ?= latest

ROOTPATH = $(shell cd ../../ && pwd)
HERE = $(shell pwd)

init:
	$(ROOTPATH)/docker/environment.sh --up network
	$(ROOTPATH)/docker/environment.sh --up registry

build: init
	(cd $(ROOTPATH)/docker/images; make)

run: build
	REGISTRY=$(REGISTRY) \
	IMAGE=$(IMAGE) \
	TAG=$(TAG) \
	USER=$(USER) \
	PROJECT_DIR=$(HERE) \
	JUPYTER_CONTAINER=YES \
	$(ROOTPATH)/docker/environment.sh --up jupyter

clean:
	find . -name '.ipynb_checkpoints' -exec rm -rf  {} +
	find . -name 'spark-warehouse' -exec rm -rf {} +

.DEFAULT_GOAL := run
.PHONY: init build run clean
