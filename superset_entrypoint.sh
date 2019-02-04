#!/bin/bash

if [ "$1" = "superset" ]; then
    gunicorn --bind 0.0.0.0:8088 \
        --workers $((2 * $(getconf _NPROCESSORS_ONLN) / 2 + 1)) \
        --timeout 60 \
        --limit-request-line 0 \
        --limit-request-field_size 0 \
        superset:app
elif [ "$1" = "celery" ]; then
    echo "Reset"
fi
