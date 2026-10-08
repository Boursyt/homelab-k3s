# kibisis

Docker Compose stacks of the NAS, in `/volume2/stacks/<stack>/`. Secrets are in a `.env` next to each compose file, not committed.

| File | Content |
|---|---|
| `postgres/` | PostgreSQL 17 primary + streaming replica + PgBouncer (TLS) + exporters |
| `postgres-public/` | PostgreSQL 17 for public services only: primary + replica + PgBouncer on port 5433, TLS required, exporters |
| `victoriametrics/` | VictoriaMetrics, 12 months retention |
| `node-exporter/` | host metrics |
| `cadvisor/` | container metrics |
| `speedtest/` | internet speed test every 6 h (2.5 Gbit/s port) |
