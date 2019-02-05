FROM ubuntu:bionic

ENV LANG "C.UTF-8"

RUN apt-get update -yqq && \
    apt-get install -yqq \
        wget \
        build-essential \
        libsasl2-dev \
        default-libmysqlclient-dev \
        curl && \
    apt-get clean

RUN wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh \
    && /bin/bash ~/miniconda.sh -b -p /opt/conda \
    && rm ~/miniconda.sh \
    && /opt/conda/bin/conda clean -tipsy \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh

ENV PATH="/opt/conda/envs/superset/bin:/opt/conda/bin:$PATH" \
    SUPERSET_HOME="/superset" \
    PYTHONPATH="/superset/:$PYTHONPATH"

WORKDIR /superset

COPY environment.yml .
COPY superset_entrypoint.sh entrypoint.sh

RUN conda env update

ENTRYPOINT [ "./entrypoint.sh" ]

EXPOSE 8088
