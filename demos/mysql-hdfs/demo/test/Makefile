SHELL=/bin/bash

PROJECT_ROOTPATH = $(shell cd .. && pwd)

demo:
	cd $(PROJECT_ROOTPATH)/src && datalabframework run main.ipynb
	cd $(PROJECT_ROOTPATH)/src && datalabframework run --profile cluster main.ipynb

clean:
	find $(PROJECT_ROOTPATH) -name '.ipynb_checkpoints' -exec rm -rf  {} +
	find $(PROJECT_ROOTPATH) -name 'spark-warehouse' -exec rm -rf {} +
	rm -rf $(PROJECT_ROOTPATH)/data/correlation.csv

.DEFAULT_GOAL := demo
.PHONY: demo clean
