#!/bin/bash
# Runs once, when the primary data directory is initialised.
set -euo pipefail
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname postgres <<SQL
CREATE ROLE replicator WITH REPLICATION LOGIN PASSWORD '${REPLICATION_PASSWORD}';
SELECT pg_create_physical_replication_slot('replica1');

-- PgBouncer looks up client passwords through this function (auth_query), so apps need no entry in userlist.txt
CREATE ROLE pgbouncer WITH LOGIN PASSWORD '${PGBOUNCER_PASSWORD}';
CREATE SCHEMA pgbouncer AUTHORIZATION pgbouncer;
CREATE FUNCTION pgbouncer.user_lookup(i_username text, OUT uname text, OUT phash text) RETURNS record
  LANGUAGE sql SECURITY DEFINER SET search_path = pg_catalog
  AS \$\$ SELECT usename::text, passwd::text FROM pg_catalog.pg_shadow WHERE usename = i_username \$\$;
REVOKE ALL ON FUNCTION pgbouncer.user_lookup(text) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION pgbouncer.user_lookup(text) TO pgbouncer;
SQL
echo "host replication replicator all scram-sha-256" >> "$PGDATA/pg_hba.conf"
