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
	$(ROOTPATH)/docker/environment.sh --up mysql
	$(ROOTPATH)/docker/environment.sh --up hdfs
	$(ROOTPATH)/docker/environment.sh --up spark


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
	$(ROOTPATH)/docker/environment.sh --down mysql
	$(ROOTPATH)/docker/environment.sh --down hdfs
	$(ROOTPATH)/docker/environment.sh --down spark

clean:
	find . -name '.ipynb_checkpoints' -exec rm -rf  {} +
	find . -name 'spark-warehouse' -exec rm -rf {} +

.DEFAULT_GOAL := run
.PHONY: up run stop down clean
