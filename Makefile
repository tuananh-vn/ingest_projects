SHELL=/bin/bash

ROOTDIR = $(shell pwd)
DOCKERENV = $(ROOTDIR)/docker/environment.sh

DEMO ?= minimal
DEMODIR = $(shell cd demos/$(DEMO) && pwd)

REGRESSION_DEMOS = minimal basic mysql-hdfs

#two modes: dlf and dev
MODE ?= dlf

build:
	cd docker/images && make

up:
	# network & containers
	$(DOCKERENV) --up network
	cat $(DEMODIR)/docker.env | sed '/^#/ d' | paste -s | xargs $(DOCKERENV) --up

	#jupyter
	WORKDIR=$(ROOTDIR) DEMO=$(DEMO) $(DOCKERENV) --up jupyter-$(MODE)

run: up
	# open browser for interactive setup
	$(DOCKERENV) --interactive jupyter-$(MODE)

test: up
	echo $(DOCKERENV) --exec jupyter-$(MODE) "cd /home/jovyan/work/demos/$(DEMO)/demo/test && make"
	$(DOCKERENV) --exec jupyter-$(MODE) "cd /home/jovyan/work/demos/$(DEMO)/demo/test && make"

$(REGRESSION_DEMOS):
	make test DEMO=$@ MODE=$(MODE)
	make down DEMO=$@ MODE=$(MODE)

regression: $(REGRESSION_DEMOS)
	echo regression done

down:
	$(DOCKERENV) --exec jupyter-$(MODE) "cd /home/jovyan/work/demos/$(DEMO)/demo/test && make clean"
	$(DOCKERENV) --down jupyter-dev jupyter-dlf
	cat $(DEMODIR)/docker.env | sed '/^#/d' | paste -s | xargs $(DOCKERENV) --down
	$(DOCKERENV) --down network

list-demos:
	echo list of demos:
	ls -1 demos

list-components:
	$(DOCKERENV) --list

.DEFAULT_GOAL := run
.PHONY: build run test regression up down demos $(REGRESSION_DEMOS)
.SILENT: build run test regression up down demos $(REGRESSION_DEMOS)
