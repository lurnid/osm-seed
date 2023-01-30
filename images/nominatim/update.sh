#!/bin/bash -e
# Because of crashing updates, we wrote this small script to update every minute the Nominatim api
LOCAL_API=http://localhost:8080
while true; do
    echo "Updating nominatim api.."
    wget -q --spider $LOCAL_API
    if [ ! $? -ne 0 ]; then
        sudo -u nominatim nominatim replication --project-dir ${PROJECT_DIR} --catch-up >>/var/log/replication.log
    fi
    sleep 10
done
