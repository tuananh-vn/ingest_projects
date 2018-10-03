SHELL=/bin/bash

REGISTRY ?= localhost:5000
IMAGE ?=datalabframework
TAG ?= latest

ROOTPATH = $(shell cd ../../ && pwd)

init:
	$(ROOTPATH)/docker/environment.sh --up network
	$(ROOTPATH)/docker/environment.sh --up registry
	(cd $(ROOTPATH)/docker/images; make)

run:
	docker run -v `pwd`:/home/jovyan/demo -d -p 8888:8888 $(REGISTRY)/$(USER)/$(IMAGE):$(TAG) start.sh jupyter lab

clean:
	find . -name '.ipynb_checkpoints' -exec rm -rf  {} +
	find . -name 'spark-warehouse' -exec rm -rf {} +

.PHONY: init run clean
