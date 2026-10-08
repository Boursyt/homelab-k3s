#!/bin/bash
# First start: clone the primary over TLS (slot replica1, -R writes the standby config).
set -euo pipefail
if [ ! -s "$PGDATA/PG_VERSION" ]; then
    until pg_isready -h postgres-public-primary -U postgres -q; do sleep 2; done
    mkdir -p "$PGDATA" && chown postgres:postgres "$PGDATA" && chmod 700 "$PGDATA"
    gosu postgres env PGPASSWORD="$REPLICATION_PASSWORD" \
        pg_basebackup -d "host=postgres-public-primary user=replicator sslmode=require" -D "$PGDATA" -X stream -S replica1 -R
fi
exec docker-entrypoint.sh "$@"
