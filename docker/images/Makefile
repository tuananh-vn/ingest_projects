SHELL=/bin/bash

# default uses an insecure local registry
REGISTRY ?= localhost:5000
USERNAME ?= $(USER)
IMAGETAG ?= latest

all: datalabframework

datalabframework:	datalabframework/Dockerfile
	$(eval IMAGENAME = $@)
	docker build -t $(USERNAME)/$(IMAGENAME):$(IMAGETAG) $@
	docker tag $(USERNAME)/$(IMAGENAME):$(IMAGETAG) $(REGISTRY)/$(USERNAME)/$(IMAGENAME):$(IMAGETAG)
	docker push $(REGISTRY)/$(USERNAME)/$(IMAGENAME):$(IMAGETAG)

.PHONY: all datalabframework
.DEFAULT_GOAL := all
