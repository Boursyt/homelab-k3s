#!/bin/bash
# Replica: clone the primary on first start (pg_basebackup, slot replica1, -R writes the standby config), then run Postgres.
set -euo pipefail
if [ ! -s "$PGDATA/PG_VERSION" ]; then
    until pg_isready -h postgres-primary -U postgres -q; do sleep 2; done
    mkdir -p "$PGDATA" && chown postgres:postgres "$PGDATA" && chmod 700 "$PGDATA"
    gosu postgres env PGPASSWORD="$REPLICATION_PASSWORD" \
        pg_basebackup -h postgres-primary -U replicator -D "$PGDATA" -X stream -S replica1 -R
fi
exec docker-entrypoint.sh "$@"
