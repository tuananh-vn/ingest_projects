# datalabframework-demos
A collections of demos for the datalabframework package

### Tools

This demos require the following tools to be installed

  - make
  - docker
  - docker-compose
  - yq

Please refer to the links for the installation

### Build the docker images

Docker images are on dockerhub.
Look at the `datalabframework-docker` repo for more info

### How to run the demos

Demos are all located under the `demos` directory or
type `make demos` to print the list of the available demos.

#### Select your demo

select a demo by adding `DEMO=<name of the demo>` to the make command.
List the available demos by typing `make demos`

For example, if the selected demo is `basic`

 - `make up DEMO=basic` creates the environment
 - `make run DEMO=basic` runs jupyter container in interactive mode

The datalabframework is illustrated via notebooks, and markdown files.
Start by opening the README.md file in the demo directory

### How to stop the Demos

After running the demo, tear down the environment by typing `make down DEMO=basic`

### Regression Test

if developing/updateing the demos, run the demos in background mode and check that everything still works. For testing purposes, use `make regression` to test the demo in background mode.

### Develop

if you wish to develop the datalabframework library, this repo acts as integration test suite. add `MODE=dev` to the make commands, for instance: `make run MODE=dev` and `make regression MODE=dev`. This will start the jupyter notebook with the datalabframework package mounted in editable mode.

To update the framework from remote use:  
`git pull && git submodule foreach git pull https://github.com/natbusa/datalabframework master`

if you are working on the framework:  
fork the framework, then pull from your own fork:  
`git pull && git submodule foreach git pull https://github.com/<yourusername>/datalabframework master`

also consider installing the following submodule aliases:
```
$ git config alias.sdiff '!'"git diff && git submodule foreach 'git diff'"
$ git config alias.spush 'push --recurse-submodules=on-demand'
$ git config alias.supdate 'submodule update --remote --merge'
```
