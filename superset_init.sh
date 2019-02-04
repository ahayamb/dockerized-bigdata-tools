#!/bin/bash

if [ "$1" = "init" ]; then
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

    echo "$USERNAME $PASSWORD $EMAIL"

    superset db upgrade
    superset init
elif [ "$1" = "reset" ]; then
    echo "Reset"
fi
