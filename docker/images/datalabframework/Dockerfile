ARG USERNAME
FROM ${USERNAME}/pyspark-notebook

USER $NB_UID

RUN pip install git+https://github.com/natbusa/datalabframework.git

# Ready to go: switch to user $NB_USER
USER $NB_USER
