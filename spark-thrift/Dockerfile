FROM openjdk:8-jre

ENV LANG "C.UTF-8"
WORKDIR /spark

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh \
    && /bin/sh miniconda.sh -b -p /opt/conda \
    && rm miniconda.sh \
    && /opt/conda/bin/conda clean -tipsy \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh

RUN wget https://archive.apache.org/dist/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz -O spark.tgz && \
    tar -zxvf spark.tgz && \
    rm spark.tgz && \
    mv */* .

ENV SPARK_HOME="/spark" \
    PATH="/opt/conda/bin:$PATH"

EXPOSE 4040
CMD [ "/bin/bash" ]
