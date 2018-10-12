SHELL=/bin/bash

PROJECT_ROOTPATH = $(shell pwd)

demo:
	datalabframework run $(PROJECT_ROOTPATH)/main.ipynb

clean:
	find $(PROJECT_ROOTPATH) -name '.ipynb_checkpoints' -exec rm -rf  {} +
	find $(PROJECT_ROOTPATH) -name 'spark-warehouse' -exec rm -rf {} +

.DEFAULT_GOAL := demo
.PHONY: demo clean
