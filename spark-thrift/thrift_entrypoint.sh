#!/bin/bash

start_server() {
    $SPARK_HOME/sbin/start-thriftserver.sh \
        --master "spark://$SPARK_MASTER_HOST:$SPARK_MASTER_PORT" \
        --hiveconf hive.server2.thrift.port=$THRIFT_PORT \
        --executor-memory=1g \
        --conf mapred.compress.map.output=true \
        --conf mapred.output.compress=true \
        --conf hive.execution.engine=true \
        --conf hive.auto.convert.join=true \
        --conf hive.exec.parallel=true \
        --conf hive.vectorized.execution.enabled=true \
        --conf hive.vectorized.execution.reduce.enabled=true \
        --conf hive.cbo.enable=true \
        --conf hive.compute.query.using.stats=true \
        --conf hive.stats.fetch.column.stats=true \
        --conf hive.stats.fetch.partition.stats=true \
        --conf hive.optimize.bucketmapjoin=true \
        --conf hive.optimize.bucketmapjoin.sortedmerge=true \
        --conf hive.enforce.bucketing=true \
        --conf hive.exec.dynamic.partition=true \
        --conf hive.exec.dynamic.partition.mode=nonstrict \
        --conf hive.optimize.skewjoin=true
}

stop_server() {
    REGEX="tail -f ${SPARK_HOME}"
    $SPARK_HOME/sbin/stop-thriftserver.sh
    kill -9 `pgrep -f "${REGEX}"`
}

if [ "$1" = "start" ]; then
    start_server
    tail -f $SPARK_HOME/logs/*
elif [ "$1" = "stop" ]; then
    stop_server
fi
