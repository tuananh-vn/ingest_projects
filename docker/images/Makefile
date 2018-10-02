SHELL=/bin/bash

# default uses an insecure local registry
REGISTRY ?= localhost:5000
TAG ?= latest

DIRS = pyspark-notebook \
			 datalabframework \
			 datalabframework-develop

all: $(DIRS)

$(DIRS):	$($(DIRS)/Dockerfile)
	$(eval IMAGE = $@)
	docker build -t $(USER)/$(IMAGE):$(TAG) $@
	docker tag $(USER)/$(IMAGE):$(TAG) $(REGISTRY)/$(USER)/$(IMAGE):$(TAG)
	docker push $(REGISTRY)/$(USER)/$(IMAGE):$(TAG)

.PHONY: all $(DIRS)
.DEFAULT_GOAL := all
