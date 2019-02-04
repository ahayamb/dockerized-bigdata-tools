FROM continuumio/miniconda3

ENV PATH "/opt/conda/envs/superset/bin:$PATH"
ENV SUPERSET_HOME "/superset"

RUN apt-get update && apt-get install -y build-essential libsasl2-dev && mkdir /superset
WORKDIR /superset

COPY environment.yml .
COPY superset_init.sh init.sh
COPY superset_entrypoint.sh entrypoint.sh
RUN chmod +x init.sh entrypoint.sh

ARG INIT_USERNAME
ARG INIT_FIRSTNAME
ARG INIT_LASTNAME
ARG INIT_EMAIL
ARG INIT_PASSWORD

RUN conda env update
CMD [ "./init.sh", "init" ]

ENTRYPOINT [ "./entrypoint.sh" ]

EXPOSE 8088
