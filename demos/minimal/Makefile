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

setup: build
	# Extra components go HERE
	# $(ROOTPATH)/docker/environment.sh --up mysql

run: setup
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

tear: stop
	#extra demo specific composents go HERE
	#$(ROOTPATH)/docker/environment.sh --down mysql

down: tear
	$(ROOTPATH)/docker/environment.sh --down registry
	$(ROOTPATH)/docker/environment.sh --down network

clean:
	find . -name '.ipynb_checkpoints' -exec rm -rf  {} +
	find . -name 'spark-warehouse' -exec rm -rf {} +

.DEFAULT_GOAL := run
.PHONY: init build setup run stop tear down clean
