FROM jupyter/pyspark-notebook

# Run the env update in as non-privileged user
USER $NB_USER

RUN git clone https://github.com/natbusa/datalabframework.git datalabframework
RUN pip install --editable datalabframework

# Ready to go: switch to user $NB_USER
USER $NB_USER
