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

test:
	$(ROOTPATH)/docker/environment.sh --exec jupyter 'cd demo/test && make'

regression:
		make up
		make test
		make down
		make clean

down:
	# >> extra components go here <<
	$(ROOTPATH)/docker/environment.sh --down jupyter
	$(ROOTPATH)/docker/environment.sh --down registry
	$(ROOTPATH)/docker/environment.sh --down network

clean:
	find $(DEMOPATH) -name '.ipynb_checkpoints' -exec rm -rf  {} +
	find $(DEMOPATH) -name 'spark-warehouse' -exec rm -rf {} +
	rm -rf $(DEMOPATH)/data/correlation.csv

.DEFAULT_GOAL := run
.PHONY: run test regression up down clean
