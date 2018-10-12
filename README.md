# datalabframework-demos
A collections of demos for the datalabframework package

### Tools

This demos require the following tools to be installed

  - make
  - docker
  - docker-compose
  - yq

Please refer to the links for the installation

### Build the images

before getting started with the demos, build the images typing `make build`

### How to run the demos

Demos are all located under the `demos` directory. Pick your favorite demo and follow the following steps:

 - `make up` creates the environment
 - `make run` runs jupyter container in interactive mode

Demo files are mapped inside the container   
(jupyer webapp is automatically launched during `make run`)

The datalabframework is illustrated via notebooks, and markdown files.

Start by opening the README.md file in the demo directory

### How to stop the Demos

After running the demo, tear down the environment by typing `make down`

### Regression Test

if developing/updateing the demos, run the demos in background mode and check that everything still works. For testing purposes, use `make regression` to test the demo in background mode.
