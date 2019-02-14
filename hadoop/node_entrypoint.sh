#!/bin/bash

initialize_keys() {
    if ! [ -f /root/.ssh/authorized_keys ]; then
        ssh-keygen -t rsa -b 1024 -f /root/.ssh/id_rsa -N ""
        cp -v /root/.ssh/{id_rsa.pub,authorized_keys}
        chmod -v 0400 /root/.ssh/authorized_keys
    fi
}

initialize_known_hosts() {
    if ! [ -f /root/.ssh/known_hosts ]; then
        ssh-keyscan localhost || :
        ssh-keyscan 0.0.0.0   || :
    fi | tee -a /root/.ssh/known_hosts
    hostname=$(hostname -f)
    if ! grep -q "$hostname" /root/.ssh/known_hosts; then
        ssh-keyscan $hostname || :
    fi | tee -a /root/.ssh/known_hosts
}

initialize_keys
service ssh start
initialize_known_hosts

tail -f /dev/null
