SHELL=/bin/bash

# default uses an insecure local registry
REGISTRY ?= localhost:5000
TAG ?= latest

DLF = datalabframework datalabframework-develop

all: pyspark-notebook $(DLF)

pyspark-notebook:	pyspark-notebook/Dockerfile
	$(eval IMAGE = $@)
	docker build -t $(USER)/$(IMAGE):$(TAG) --build-arg USER=$(USER) $@
	docker tag $(USER)/$(IMAGE):$(TAG) $(REGISTRY)/$(USER)/$(IMAGE):$(TAG)
	docker push $(REGISTRY)/$(USER)/$(IMAGE):$(TAG)

$(DLF):	$($(DLF)/Dockerfile)
	$(eval IMAGE = $@)
	docker build --no-cache -t $(USER)/$(IMAGE):$(TAG) --build-arg USER=$(USER) $@
	docker tag $(USER)/$(IMAGE):$(TAG) $(REGISTRY)/$(USER)/$(IMAGE):$(TAG)
	docker push $(REGISTRY)/$(USER)/$(IMAGE):$(TAG)

.PHONY: all pyspark-notebook $(DLF)
.DEFAULT_GOAL := all
