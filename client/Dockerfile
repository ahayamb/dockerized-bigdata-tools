FROM continuumio/miniconda3:4.5.4

RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get clean && \
    pip install pyspark
