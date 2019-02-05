FROM ubuntu:bionic

ENV LANG "C.UTF-8"

RUN apt-get update -y && \
    apt-get install -y \
        ca-certificates-java \
        openjdk-8-jre \
        wget && \
    update-ca-certificates -f && \
    apt-get clean

WORKDIR /spark
RUN wget http://172.17.0.1:7777/dist/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz -O spark.tgz && \
    tar -zxvf spark.tgz && \
    rm spark.tgz && \
    mv */* .

ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/" \
    SPARK_HOME="/spark"

EXPOSE 4040
CMD [ "/bin/bash" ]
