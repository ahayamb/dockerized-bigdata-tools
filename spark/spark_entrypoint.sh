#!/bin/bash

start_master() {
    /bin/bash -c "${SPARK_HOME}/sbin/start-master.sh"
    /bin/bash -c "tail -f ${SPARK_HOME}/logs/*"
}

start_worker() {
    /bin/bash -c "${SPARK_HOME}/sbin/start-slave.sh spark://${SPARK_MASTER_HOST}:${SPARK_MASTER_PORT}"
    /bin/bash -c "tail -f ${SPARK_HOME}/logs/*"
}

if [ "$1" = "master" ]; then
    start_master
elif [ "$1" = "worker" ]; then
    start_worker
fi
