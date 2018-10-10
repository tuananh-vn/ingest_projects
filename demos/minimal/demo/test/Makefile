SHELL=/bin/bash

DEMOPATH = $(shell cd .. && pwd)
ROOTPATH = $(shell cd $(DEMOPATH)/../../ && pwd)

demo:
	datalabframework run $(DEMOPATH)/src/main.ipynb

clean:
	find . -name '.ipynb_checkpoints' -exec rm -rf  {} +
	find . -name 'spark-warehouse' -exec rm -rf {} +

.DEFAULT_GOAL := demo
.PHONY: demo clean
