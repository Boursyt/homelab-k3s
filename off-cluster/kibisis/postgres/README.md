# PostgreSQL

Shared database of the cluster apps.

| File | Content |
|---|---|
| `compose.yaml` | primary, streaming replica, PgBouncer, exporters |
| `init/10-replication-pgbouncer.sh` | first start: replication user and slot, PgBouncer auth function |
| `replica-entrypoint.sh` | clones the primary on first start |
| `pgbouncer/pgbouncer.ini` | session pooling, TLS required, TCP keepalive |
