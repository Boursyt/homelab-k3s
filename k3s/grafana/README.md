# Grafana

Dashboards on VictoriaMetrics (grafana.lab).

| File | Content |
|---|---|
| `helmrelease-grafana.yaml` | Grafana chart, 2 replicas, database in the NAS Postgres |
| `dashboards/` | dashboards as ConfigMaps loaded by the Grafana sidecar (folder Homelab) |
| `secret-grafana-admin.sops.yaml`, `secret-grafana-db.sops.yaml` | Secrets encrypted with SOPS (see the root README) |
