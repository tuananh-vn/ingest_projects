SHELL=/bin/bash

DOCKERENV = $(shell cd ../../ && pwd)/docker/environment.sh
STATE ?= up

set-state:
	# demo specific containers
	$(DOCKERENV) --$(STATE) mysql hdfs spark

.PHONY: set-state
