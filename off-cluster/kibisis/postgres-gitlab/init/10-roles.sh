#!/bin/bash
set -euo pipefail
psql -v ON_ERROR_STOP=1 -U postgres -v mon="$MONITORING_PASSWORD" -v bnc="$PGBOUNCER_PASSWORD" <<'SQL'
CREATE ROLE monitoring LOGIN PASSWORD :'mon' IN ROLE pg_monitor;

-- PgBouncer looks up client passwords through this function (auth_query)
CREATE ROLE pgbouncer LOGIN PASSWORD :'bnc';
CREATE SCHEMA pgbouncer AUTHORIZATION pgbouncer;
CREATE FUNCTION pgbouncer.user_lookup(i_username text, OUT uname text, OUT phash text) RETURNS record
  LANGUAGE sql SECURITY DEFINER SET search_path = pg_catalog
  AS $$ SELECT usename::text, passwd::text FROM pg_catalog.pg_shadow WHERE usename = i_username $$;
REVOKE ALL ON FUNCTION pgbouncer.user_lookup(text) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION pgbouncer.user_lookup(text) TO pgbouncer;
SQL
