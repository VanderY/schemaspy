#!/bin/sh
[ -d $SCHEMASPY_DRIVERS ] && export DRIVER_PATH=$SCHEMASPY_DRIVERS || export DRIVER_PATH=/drivers_inc/
echo -n "Using drivers:"
ls -Ax $DRIVER_PATH | sed -e 's/  */, /g'
exec java -jar /usr/local/lib/schemaspy/schemaspy*.jar -dp $DRIVER_PATH -o $SCHEMASPY_OUTPUT "$@" -t pgsql -u $SCHEMASPY_POSTGRES_USER -p $SCHEMASPY_POSTGRES_PASSWORD -host $SCHEMASPY_HOST -port 5432 -db $SCHEMASPY_POSTGRES_DB