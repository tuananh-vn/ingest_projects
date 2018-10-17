SHELL=/bin/bash

ROOTDIR = $(shell pwd)
DOCKERENV = $(ROOTDIR)/docker/environment.sh

DEMO ?= minimal
DEMODIR = $(shell cd demos/$(DEMO) && pwd)

REGRESSION_DEMOS = $(shell ls demos)

#two modes: dlf and dev
MODE ?= dlf

build:
	cd docker/images && make

up:
	# network & containers
	$(DOCKERENV) --up network
	cd $(DEMODIR) && make STATE=up

	#jupyter
	WORKDIR=$(ROOTDIR) DEMO=$(DEMO) $(DOCKERENV) --up jupyter-$(MODE)

run: up
	# open browser for interactive setup
	$(DOCKERENV) --interactive jupyter-$(MODE)

test: up
	$(DOCKERENV) --exec jupyter-$(MODE) "cd /home/jovyan/work/demos/$(DEMO)/demo/test && make"

$(REGRESSION_DEMOS):
	make test DEMO=$@ MODE=$(MODE)
	make down DEMO=$@ MODE=$(MODE)

regression: $(REGRESSION_DEMOS)
	echo regression done

down:
	$(DOCKERENV) --exec jupyter-$(MODE) "cd /home/jovyan/work/demos/$(DEMO)/demo/test && make clean"
	$(DOCKERENV) --down jupyter-dev jupyter-dlf

	cd $(DEMODIR) && make STATE=down
	$(DOCKERENV) --down network

demos:
	echo list of demos:
	ls -1 demos

.DEFAULT_GOAL := run
.PHONY: build run test regression up down demos $(REGRESSION_DEMOS)
#.SILENT: build run test regression up down demos $(REGRESSION_DEMOS)
