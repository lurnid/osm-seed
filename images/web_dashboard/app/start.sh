#!/usr/bin/env bash
set -e
export POSTGRES_HOST=localhost
export POSTGRES_DB=dashboard
export POSTGRES_USER=postgres
export POSTGRES_PORT=5432
# POSTGRES_PASSWORD, comes from env var
flag=true
/usr/local/bin/docker-entrypoint.sh "postgres" &
while "$flag" = true; do
    pg_isready -h $POSTGRES_HOST -p $POSTGRES_PORT >/dev/null 2>&2 || continue
    flag=false
    echo "===================Start app======================="
    python3 manage.py migrate
    python3 manage.py createsuperuser --no-input
    python3 manage.py runserver 0.0.0.0:8000
done
