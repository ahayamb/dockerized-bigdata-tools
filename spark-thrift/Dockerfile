FROM openjdk:8-jre

ENV LANG="C.UTF-8" \
    SPARK_URL="https://archive.apache.org/dist/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz"

WORKDIR /spark

RUN wget ${SPARK_URL} -O spark.tgz && \
    tar -zxvf spark.tgz && \
    rm spark.tgz && \
    mv */* .

RUN apt-get update \
        && apt-get install -y procps \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

COPY thrift_entrypoint.sh entrypoint.sh

ENV SPARK_HOME="/spark" 

CMD [ "/bin/bash" ]
