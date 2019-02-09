FROM openjdk:8-jre

ENV LANG="C.UTF-8" \
    MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh" \
    SPARK_URL="https://archive.apache.org/dist/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz"

WORKDIR /spark

RUN wget ${MINICONDA_URL} -O miniconda.sh \
    && /bin/sh miniconda.sh -b -p /opt/conda \
    && rm miniconda.sh \
    && /opt/conda/bin/conda clean -tipsy \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && apt-get update \
        && apt-get install -y procps \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

RUN wget ${SPARK_URL} -O spark.tgz && \
    tar -zxvf spark.tgz && \
    rm spark.tgz && \
    mv */* .

COPY spark_entrypoint.sh entrypoint.sh

ENV SPARK_HOME="/spark" \
    PATH="/opt/conda/bin:$PATH"

CMD [ "/bin/bash" ]
