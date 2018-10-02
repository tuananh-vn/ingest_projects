SHELL=/bin/bash

cicd:
	# start cicd services
	docker-compose -f deploy/docker-compose.yml up -d

build:
	#buid the container

push:
	#push the image to the registry

up:
	#create volumes with the right ownerships
	#start docker compose

ci:
	#dowload the fly tool
	#load the pipeline

trigger:
	#trigger the pipelines manually

down:
	docker-compose -f deploy/docker-compose.yml down

clean:
	#clean the directory from temp files and output
	find . -name '.ipynb_checkpoints' -exec rm -rf  {} +
	find . -name 'spark-warehouse' -exec rm -rf {} +

.PHONY: cicd run clean
