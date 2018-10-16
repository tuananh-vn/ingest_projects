SHELL=/bin/bash

run:
	docker run -v `pwd`:/home/jovyan/demo -p 8888:8888 natbusa/datalabframework start.sh jupyter lab &

clean:
	find . -name '.ipynb_checkpoints' -exec rm -rf  {} +
	find . -name 'spark-warehouse' -exec rm -rf {} +

.PHONY: run clean
