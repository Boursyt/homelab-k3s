# Gatus config

Checks, one file per section; Gatus merges them.

| File | Content |
|---|---|
| `base.yaml` | storage (NAS Postgres), UI, Prometheus metrics on /metrics, ntfy alerting |
| `apps.yaml` | user apps |
| `services.yaml` | infrastructure services |
| `cluster.yaml` | Kubernetes API and nodes |
| `hosts.yaml` | machines (node-exporter reachability) |
| `network.yaml` | gateway, VIP, Traefik, VPN, internet, public DNS (Glance Network block) |
| `announcements.yaml` | incidents shown at the top of the page |

A check with `extra-labels: { section, icon, href, order }` shows up in the Glance launcher: `section` = block title, `icon` = name from [dashboard-icons](https://github.com/homarr-labs/dashboard-icons), optional: by default the check name in lowercase, spaces → `-`, without `(…)`, `order` = 2 digits (first = section: 1 Apps, 2 Monitoring, 3 Infrastructure).
A `desc` label also lists the check in the PRIVATE part of the public Glance (name, description and status only, no link).
