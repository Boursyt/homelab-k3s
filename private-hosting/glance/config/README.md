# Glance config

Glance dashboard, one file per block.

| File | Content |
|---|---|
| `glance.yml` | server, branding, custom CSS (+ Latte overrides), theme following the device mode, 30 s auto-refresh, page include |
| `theme.yml` | Catppuccin Mocha (dark) and Latte (light, `default-light`); picker hidden |
| `homelab.yml` | page layout |
| `hardware.yml` | machines reachability, from the Gatus `Hosts` checks grouped by their `category` label (`model`, `order` labels) |
| `k3s.yml` | cluster usage and nodes (control plane / workers, CPU temperature of Pis and OptiPlex) |
| `nas.yml` | NAS usage |
| `printer.yml` | 3D printer, AMS and low stock spools (Home Assistant, Spoolman) |
| `apps.yml` | launcher: every private Gatus check with an `href` label, grouped by its `section` label, sorted by `order` (2 digits, first = section) |
| `public.yml` | public services (lab.pub), from the public Gatus |
| `status.yml` | Gatus summary |
| `backups.yml` | last backups |
| `databases.yml` | Postgres and PgBouncer |
| `network.yml` | latency probes |
| `speedtest.yml` | internet speed (NAS and cluster) |
| `ingress.yml` | Traefik traffic |
