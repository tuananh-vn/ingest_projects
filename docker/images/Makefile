SHELL=/bin/bash

USERNAME ?= $(USER)
IMAGETAG ?= latest

all: pyspark-notebook datalabframework

datalabframework:	datalabframework/Dockerfile
	$(eval IMAGENAME = $@)
	docker build -t $(USERNAME)/$(IMAGENAME):$(IMAGETAG) --build-arg USERNAME=$(USERNAME) $@

pyspark-notebook:	pyspark-notebook/Dockerfile
	$(eval IMAGENAME = $@)
	docker build -t $(USERNAME)/$(IMAGENAME):$(IMAGETAG) $@

.PHONY: all pyspark-notebook datalabframework
.DEFAULT_GOAL := all
