FROM continuumio/miniconda3

ENV PATH "/opt/conda/envs/superset/bin:$PATH"
ENV SUPERSET_HOME "/superset"

RUN apt-get update && apt-get install -y build-essential libsasl2-dev && mkdir /superset
WORKDIR /superset

COPY environment.yml .
COPY superset_entrypoint.sh entrypoint.sh

RUN conda env update
