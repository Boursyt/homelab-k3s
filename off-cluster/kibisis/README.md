# kibisis

Docker Compose stacks of the NAS, deployed by doco-cd from `.doco-cd.nas.yml` (stacks not listed there are still by hand, in `/volume2/stacks/<stack>/`). Secrets: SOPS-encrypted `secrets.env` next to the compose file (stacks managed by doco-cd) or a plain `.env`, never committed.

| File | Content |
|---|---|
| `postgres/` | PostgreSQL 17 primary + streaming replica + PgBouncer (TLS) + exporters |
| `postgres-public/` | PostgreSQL 17 for public services only: primary + replica + PgBouncer on port 5433, TLS required, exporters |
| `garage/` | Garage S3 object storage for GitLab, data on `/volume1/garage` |
| `postgres-gitlab/` | PostgreSQL 17 dedicated to GitLab: primary + PgBouncer on port 5435, TLS required, exporters |
| `doco-cd/` | doco-cd: deploys the stacks listed in `.doco-cd.nas.yml` from git |
| `docker-net-heal/` | boot service: recreates the containers Docker starts without a network (NIC link flap at boot) |
| `victoriametrics/` | VictoriaMetrics, 12 months retention |
| `victorialogs/` | VictoriaLogs, 30 days retention |
| `node-exporter/` | host metrics |
| `cadvisor/` | container metrics |
| `speedtest/` | internet speed test every 6 h (2.5 Gbit/s port) |
