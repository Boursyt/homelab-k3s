# Dashboards

Grafana dashboards, folder Homelab. Each JSON becomes a ConfigMap loaded by the Grafana sidecar.

| File | Content |
|---|---|
| `k3s-traefik.json` | k3s components and Traefik traffic |
| `postgres.json` | NAS PostgreSQL primary / replica and PgBouncer |
| `nas-docker.json` | NAS Docker containers (cAdvisor) |
| `plugs.json` | Zigbee smart plugs: power, energy, cost |
| `flux-cluster.json`, `flux-control-plane.json` | Flux objects state and controllers, from [fluxcd/flux2-monitoring-example](https://github.com/fluxcd/flux2-monitoring-example) (commit 7ab65dc) |

"Node Exporter Full" (grafana.com 1860) is not copied here: Grafana downloads it, see `dashboards` in `../helmrelease-grafana.yaml`.
