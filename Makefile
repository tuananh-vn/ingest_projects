SHELL=/bin/bash

ROOTDIR = $(shell pwd)
DOCKERENV = $(ROOTDIR)/docker/environment.sh

DEMO ?= mysql-hdfs
DEMODIR = $(shell cd demos/$(DEMO) && pwd)
PROJECTDIR = $(DEMODIR)/demo

#two modes: dlf and dev
MODE ?= dlf

build:
	cd docker/images && make

up:
	# network & containers
	$(DOCKERENV) --up network
	cd $(DEMODIR) && make STATE=up

	#jupyter
	PROJECTDIR=$(PROJECTDIR) $(DOCKERENV) --up jupyter-$(MODE)

run: up
	# open browser for interactive setup
	$(DOCKERENV) --interactive jupyter-$(MODE)

test: up
	$(DOCKERENV) --exec jupyter-$(MODE) 'cd demo/test && make'

regression:
		make test
		make down
		make clean

down:
	$(DOCKERENV) --exec jupyter-$(MODE) 'cd demo/test && make clean'
	$(DOCKERENV) --down jupyter-dev jupyter-dlf

	cd $(DEMODIR) && make STATE=down
	$(DOCKERENV) --down network


.DEFAULT_GOAL := run
.PHONY: build run test regression up down clean
