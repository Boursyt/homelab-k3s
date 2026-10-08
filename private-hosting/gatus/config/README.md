# Gatus config

Checks, one file per section; Gatus merges them.

| File | Content |
|---|---|
| `base.yaml` | storage (NAS Postgres), UI, Prometheus metrics on /metrics, ntfy alerting |
| `apps.yaml` | user apps; `extra-labels` feed the Glance Apps block |
| `services.yaml` | infrastructure services |
| `cluster.yaml` | Kubernetes API and nodes |
| `hosts.yaml` | machines (node-exporter reachability) |
| `network.yaml` | gateway, VIP, Traefik, VPN, internet, public DNS (Glance Network block) |
| `announcements.yaml` | incidents shown at the top of the page |
