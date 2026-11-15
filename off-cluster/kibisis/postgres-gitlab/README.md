# PostgreSQL (GitLab)

Dedicated instance for the self-hosted GitLab (its own connections, memory and upgrade rhythm), no replica. TLS required for every network connection.

| File | Content |
|---|---|
| `compose.yaml` | primary (512 MB shared buffers, 150 connections), PgBouncer on port 5435, exporters (9192 primary, 9193 PgBouncer) |
| `pg_hba.conf` | network connections: TLS + password only |
| `init/10-roles.sh` | first start: monitoring and PgBouncer roles |
| `pgbouncer/pgbouncer.ini` | session pooling, TLS to clients and to the primary |

Not committed, on the NAS only (`/volume2/stacks/postgres-gitlab/`): `.env` (`POSTGRES_PASSWORD`, `MONITORING_PASSWORD`, `PGBOUNCER_PASSWORD`), `tls/` and `pgbouncer/tls/` (self-signed certificate), `pgbouncer/userlist.txt`, `data/`.
The role and database `gitlab` are created by hand (extensions `pg_trgm` and `btree_gist` are created by the restore, they are trusted).
