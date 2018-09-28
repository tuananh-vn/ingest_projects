SHELL=/bin/bash

ingest:
	datalabframework -version

clean:
	find . -name '.ipynb_checkpoints' -exec rm -rf  {} +
	find . -name 'spark-warehouse' -exec rm -rf {} +

.PHONY: ingest clean
