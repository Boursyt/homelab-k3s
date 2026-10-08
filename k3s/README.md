# k3s

The cluster platform: what every hosted service relies on.

| Path | Content |
|---|---|
| `nodes/` | k3s config of each Pi, systemd timer (copied to the nodes, not applied) |
| `kube-vip/` | API virtual IP |
| `traefik/` | ingress controller config |
| `cert-manager/` | TLS certificates |
| `nfs/` | NFS volumes on the NAS |
| `devices/` | host devices (Zigbee dongle) as Kubernetes resources |
| `system-upgrade/` | automatic k3s upgrades |
| `databases/` | Service to the NAS PostgreSQL |
| `backup/` | Postgres dumps and restic backups |
| `metrics/` | metrics collection into VictoriaMetrics |
| `grafana/` | dashboards |
