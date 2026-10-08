# Init scripts

Run once by PostgreSQL on an empty data directory.

| File | Content |
|---|---|
| `10-roles.sh` | `monitoring` (pg_monitor), `replicator` + slot `replica1`, `pgbouncer` + its password lookup function |
