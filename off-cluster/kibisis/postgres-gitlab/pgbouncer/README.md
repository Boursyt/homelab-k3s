# PgBouncer

Mounted into the PgBouncer container. `userlist.txt` and `tls/` stay on the NAS.

| File | Content |
|---|---|
| `pgbouncer.ini` | session pooling (GitLab needs it), 100 server connections, TLS required for clients and towards the primary |
