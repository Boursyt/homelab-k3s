# PgBouncer

Mounted into the PgBouncer container. `userlist.txt` and `tls/` stay on the NAS.

| File | Content |
|---|---|
| `pgbouncer.ini` | session pooling, TLS required for clients and used towards the primary, TCP keepalive |
