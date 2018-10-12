# Demo: mysql-hdfs

This demo is about writing and reading file to/from hdfs and mysql

Learn how to define the following via the `metadata.yml` file:
 - data providers,
 - data resources,
 - spark engine (standalone cluser)
 - multple metadata profiles
 - connect to HDFS
 - connect to mysql

### Run the demo interactively

Type `make run`, and open `demo/main.ipynb` to start

### Stop the demo
Type `make down` to stop the demo and clean up the docker resources

### Demo testing

Type `make regression`
