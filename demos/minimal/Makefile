SHELL=/bin/bash

REGISTRY ?= localhost:5000
IMAGE ?=datalabframework
TAG ?= latest

ROOTPATH = $(shell cd ../../ && pwd)
HERE = $(shell pwd)

up:
	$(ROOTPATH)/docker/environment.sh --up network
	$(ROOTPATH)/docker/environment.sh --up registry
	# Extra components go HERE

run: up
	REGISTRY=$(REGISTRY) \
	IMAGE=$(IMAGE) \
	TAG=$(TAG) \
	USER=$(USER) \
	PROJECT_DIR=$(HERE) \
	JUPYTER_CONTAINER=YES \
	$(ROOTPATH)/docker/environment.sh --up jupyter

stop:
	REGISTRY=$(REGISTRY) \
	IMAGE=$(IMAGE) \
	TAG=$(TAG) \
	USER=$(USER) \
	PROJECT_DIR=$(HERE) \
	JUPYTER_CONTAINER=YES \
	$(ROOTPATH)/docker/environment.sh --down jupyter

down: stop
	$(ROOTPATH)/docker/environment.sh --down registry
	$(ROOTPATH)/docker/environment.sh --down network
	#extra demo specific composents go HERE

clean:
	find . -name '.ipynb_checkpoints' -exec rm -rf  {} +
	find . -name 'spark-warehouse' -exec rm -rf {} +

.DEFAULT_GOAL := run
.PHONY: up run stop down clean
