FROM eda/base

COPY requirements.txt .

RUN apt-get update && \
    apt-get -y install default-libmysqlclient-dev && \
    pip install -r requirements.txt

ENV PATH=/opt/conda/envs/superset/bin:/opt/conda/bin:$PATH \
    PYTHONPATH=/superset/:$PYTHONPATH

ENTRYPOINT [ "./entrypoint.sh" ]
EXPOSE 8088
