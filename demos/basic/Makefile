SHELL=/bin/bash

DEMOPATH = $(shell cd demo && pwd)
ROOTPATH = $(shell cd ../../ && pwd)

up:
	# minimal setup
	$(ROOTPATH)/docker/environment.sh --up network
	$(ROOTPATH)/docker/environment.sh --up registry

	# create the datalabframework image if required
	cd $(ROOTPATH)/docker/images && make

	# >> extra components go here <<

	# start jupyter
	PROJECTDIR=$(DEMOPATH) $(ROOTPATH)/docker/environment.sh --up jupyter

run: up
	$(ROOTPATH)/docker/environment.sh --interactive jupyter

test: up
	$(ROOTPATH)/docker/environment.sh --exec jupyter 'cd demo/test && make'
	$(ROOTPATH)/docker/environment.sh --exec jupyter 'cd demo/test && make clean'

regression:
		make test
		make down
		make clean

down:
	$(ROOTPATH)/docker/environment.sh --down jupyter
	# >> extra components go here <<
	$(ROOTPATH)/docker/environment.sh --down registry
	$(ROOTPATH)/docker/environment.sh --down network

.DEFAULT_GOAL := run
.PHONY: run test regression up down clean
