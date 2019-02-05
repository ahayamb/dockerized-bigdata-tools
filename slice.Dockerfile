FROM eda/base

COPY requirements.txt .

RUN pip install -r requirements.txt

ENTRYPOINT [ "./entrypoint.sh" ]
EXPOSE 8088
