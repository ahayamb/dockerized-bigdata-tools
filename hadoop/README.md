# How to Run
1. Execute `docker-compose up --build -d --scale worker=<number of workers>`
1. Setup passwordless ssh & worker registration to the master node by executing `python inject_keys.py`
1. Execute `docker-compose exec master ./entrypoint master`

# Submitting Spark Job to YARN Cluster
1. Execute
```bash
export HADOOP_CONF_DIR=<directory in which core-site.xml & yarn-site.xml exist>
export YARN_CONF_DIR=<directory in which core-site.xml & yarn-site.xml exist>
export PYSPARK_PYTHON=./environment/bin/python
./bin/spark-submit \
    --conf spark.yarn.appMasterEnv.PYSPARK_PYTHON=./environment/bin/python \
    --master yarn \
    --deploy-mode cluster \
    --archives environment.zip#environment \    # zipped environment, for simplicity you can use `conda-pack`
    --py-files archive.zip \                    # zipped project
    main.py --param1 value --param2 value
```

# Notes
1. Add container to ip resolving statement to `/etc/hosts` (for better job monitoring experience via browser)
1. Master address stated in `core-site.xml` & `yarn-site.xml` should be accessible from submitter
