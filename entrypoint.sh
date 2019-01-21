#!/bin/sh

until pg_isready -h $PGBOUNCER_HOST -p $PGBOUNCER_PORT; do echo waiting for pgbouncer; sleep 2; done;

while true;
do
    /pgbouncer_exporter --pgBouncer.connectionString=postgres://$PGBOUNCER_USER:$PGBOUNCER_PASSWORD@$PGBOUNCER_HOST:$PGBOUNCER_PORT/pgbouncer?sslmode=disable;
done