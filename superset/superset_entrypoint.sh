#!/bin/bash

init_superset_admin() {
    if [[ $(fabmanager list-users --app superset | grep "role\:\[Admin\]" | wc -l) -eq 0 ]]; then
        if [ "$INIT_USERNAME" ]; then USERNAME="$INIT_USERNAME"; else USERNAME=admin; fi
        if [ "$INIT_FIRSTNAME" ]; then FIRSTNAME="$INIT_FIRSTNAME"; else FIRSTNAME=admin; fi
        if [ "$INIT_LASTNAME" ]; then LASTNAME="$INIT_LASTNAME"; else LASTNAME=admin; fi
        if [ "$INIT_EMAIL" ]; then EMAIL="$INIT_EMAIL"; else EMAIL=admin@admin.org; fi
        if [ "$INIT_PASSWORD" ]; then PASSWORD="$INIT_PASSWORD"; else PASSWORD=admin; fi
        
        fabmanager create-admin --app superset \
            --username ${USERNAME} \
            --firstname ${FIRSTNAME} \
            --lastname ${LASTNAME} \
            --email ${EMAIL} \
            --password ${PASSWORD}

        superset db upgrade
        superset init
    fi
}

if [ "$1" = "initialize" ]; then
    init_superset_admin
elif [ "$1" = "execute" ]; then
    /bin/bash -c "superset ${@:2}"
fi

if [ "$2" = "superset" ]; then
    gunicorn --bind 0.0.0.0:8088 \
        --workers $((2 * $(getconf _NPROCESSORS_ONLN) / 2 + 1)) \
        -k gevent \
        --timeout 480 \
        --limit-request-line 0 \
        --limit-request-field_size 0 \
        superset:app
elif [ "$2" = "celery" ]; then
    echo "Reset"
fi
