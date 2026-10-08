# PostgreSQL (public)

Separate instance for public services, isolated from the private one. TLS required for every network connection.

| File | Content |
|---|---|
| `compose.yaml` | primary, streaming replica, PgBouncer on port 5433, exporters (9189 primary, 9190 replica, 9191 PgBouncer) |
| `pg_hba.conf` | network connections: TLS + password only, replication for `replicator` |
| `replica-entrypoint.sh` | clones the primary over TLS on first start |
| `init/10-roles.sh` | first start: monitoring, replication and PgBouncer roles |
| `pgbouncer/pgbouncer.ini` | session pooling, TLS to clients and to the primary |

Not committed, on the NAS only: `.env` (`POSTGRES_PASSWORD`, `MONITORING_PASSWORD`, `REPLICATION_PASSWORD`, `PGBOUNCER_PASSWORD`), `tls/` and `pgbouncer/tls/` (self-signed certificate), `pgbouncer/userlist.txt`, `data/`.
