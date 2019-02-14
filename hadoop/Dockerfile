FROM openjdk:8-jre

WORKDIR /hadoop

ENV LANG="C.UTF-8" \
    HADOOP_URL="http://10.181.15.100:8080/hadoop-2.9.2.tar.gz" \
    HADOOP_HOME="/hadoop"

ENV HADOOP_INSTALL="${HADOOP_HOME}" \
    HADOOP_MAPRED_HOME=${HADOOP_HOME} \
    HADOOP_COMMON_HOME=${HADOOP_HOME} \
    HADOOP_HDFS_HOME=${HADOOP_HOME} \
    YARN_HOME=${HADOOP_HOME} \
    HADOOP_COMMON_LIB_NATIVE_DIR="${HADOOP_HOME}/lib/native" \
    PATH="$PATH:$HADOOP_HOME/sbin:${HADOOP_HOME}/bin"

RUN apt-get update \
    && apt-get install -y ssh nano \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN wget ${HADOOP_URL} -O hadoop.tgz && \
    tar -zxvf hadoop.tgz && \
    rm hadoop.tgz && \
    mv */* . && \
    sed -i -e 's+export JAVA_HOME=${JAVA_HOME}+export JAVA_HOME=/docker-java-home/jre+g' ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh

RUN mkdir -p /data/hadoop-data/nn && \
    mkdir -p /data/hadoop-data/snn && \
    mkdir -p /data/hadoop-data/dn && \
    mkdir -p /data/hadoop-data/mapred/system && \
    mkdir -p /data/hadoop-data/mapred/local

COPY node_entrypoint.sh entrypoint.sh
COPY ssh/config /root/.ssh/
COPY hadoop-config/* /hadoop/etc/hadoop/

EXPOSE 50090 50105 50075 50070 50475 50470 8032 8030 8088 8090 8031 8033 9000

CMD [ "/bin/bash" ]
