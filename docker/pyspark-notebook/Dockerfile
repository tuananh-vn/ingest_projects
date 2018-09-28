FROM jupyter/scipy-notebook

USER root

ENV APACHE_SPARK_VERSION=2.3.2
ENV HADOOP_VERSION=2.8.5

RUN apt-get -y update && \
    apt-get install --no-install-recommends -y openjdk-8-jre-headless ca-certificates-java && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN cd /tmp && \
        wget https://archive.apache.org/dist/spark/spark-${APACHE_SPARK_VERSION}/spark-${APACHE_SPARK_VERSION}-bin-without-hadoop.tgz && \
        echo "79D1DE6870CF43ECC059D4423540124610EF00ABC929C171BE42548B505F115906E251E4604ED7D22B6A8CCE012A845D90017319C2ABB3D5D700369B1C335C6D *spark-${APACHE_SPARK_VERSION}-bin-without-hadoop.tgz" | sha512sum -c - && \
        tar xzf spark-${APACHE_SPARK_VERSION}-bin-without-hadoop.tgz -C /usr/local --owner root --group root --no-same-owner && \
        rm spark-${APACHE_SPARK_VERSION}-bin-without-hadoop.tgz && \
        cd /usr/local && ln -s spark-${APACHE_SPARK_VERSION}-bin-without-hadoop spark

RUN cd /tmp && \
        wget http://mirror.downloadvn.com/apache/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz && \
        tar xzf hadoop-${HADOOP_VERSION}.tar.gz -C /usr/local --owner root --group root --no-same-owner && \
        rm hadoop-${HADOOP_VERSION}.tar.gz && \
        cd /usr/local && ln -s hadoop-${HADOOP_VERSION} hadoop

ENV SPARK_HOME=/usr/local/spark
ENV HADOOP_HOME=/usr/local/hadoop
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/

RUN set -eux; \
    cd ${SPARK_HOME}/jars; \
    wget http://central.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.8.5/hadoop-aws-2.8.5.jar; \
    wget http://central.maven.org/maven2/org/apache/httpcomponents/httpclient/4.5.3/httpclient-4.5.3.jar; \
    wget http://central.maven.org/maven2/com/amazonaws/aws-java-sdk-core/1.11.234/aws-java-sdk-core-1.11.234.jar; \
    wget http://central.maven.org/maven2/com/amazonaws/aws-java-sdk/1.11.234/aws-java-sdk-1.11.234.jar; \
    wget http://central.maven.org/maven2/com/amazonaws/aws-java-sdk-kms/1.11.234/aws-java-sdk-kms-1.11.234.jar; \
    wget http://central.maven.org/maven2/com/amazonaws/aws-java-sdk-s3/1.11.234/aws-java-sdk-s3-1.11.234.jar

ENV PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.7-src.zip
ENV SPARK_OPTS --driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --driver-java-options=-Dlog4j.logLevel=info
RUN echo 'SPARK_DIST_CLASSPATH=$(${HADOOP_HOME}/bin/hadoop classpath)' > ${SPARK_HOME}/conf/spark-env.sh
RUN chmod 755 ${SPARK_HOME}/conf/spark-env.sh

USER $NB_UID

RUN conda install -y 'pyarrow' && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
