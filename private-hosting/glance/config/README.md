# Glance config

Glance dashboard, one file per block.

| File | Content |
|---|---|
| `glance.yml` | server, branding, custom CSS (+ Latte overrides), theme following the device mode, 30 s auto-refresh, page include |
| `theme.yml` | Catppuccin Mocha (dark) and Latte (light, `default-light`); picker hidden |
| `homelab.yml` | page Homelab (global states, kept light) |
| `page-db.yml`, `page-network.yml`, `page-git.yml`, `page-apps.yml` | pages DB, Network, Git, Apps (listed in `glance.yml`) |
| `hardware.yml` | machines reachability, from the Gatus `Hosts` checks grouped by their `category` label (`model`, `order` labels) |
| `k3s.yml` | cluster usage and nodes (control plane / workers, CPU temperature of Pis and OptiPlex) |
| `nas.yml` | NAS usage |
| `printer.yml` | 3D printer, AMS and low stock spools (Home Assistant, Spoolman) |
| `apps.yml` | launcher: every private Gatus check with an `href` label, grouped by its `section` label, sorted by `order` (2 digits, first = section) |
| `public.yml` | public services (lab.pub), from the public Gatus |
| `status.yml` | Gatus summary |
| `backups.yml` | global backup state (green / orange when some are older than 26 h / red when half or more are) |
| `backups-detail.yml` | every backup: age, size, restic snapshots (page DB) |
| `databases.yml` | global state of the 3 Postgres stacks (primary, replica, PgBouncer, lag, connections) |
| `db-private.yml`, `db-public.yml`, `db-gitlab.yml` | detail of each stack: connections, tx/s, queries/s, cache hit, sizes (generated from one template, same query with another `stack` label) |
| `git-mrs.yml`, `git-pipelines.yml`, `git-main.yml` | open merge requests (`renovate/manual-*` highlighted), last pipelines, last commits and gitlab.com / GitHub mirror sync. Read-only GitLab token `GITLAB_TOKEN` (Secret `gitlab-token`, project token `glance (read only)`, Reporter, `read_api`, expires ~2027-11) |
| `apps-namespaces.yml`, `apps-traffic.yml`, `traffic.yml` | memory / CPU / restarts per namespace, Traefik traffic per service (req/s, p95, 5xx), network traffic per node |
| `network.yml` | latency probes |
| `speedtest.yml` | internet speed (NAS and cluster) |
| `ingress.yml` | Traefik traffic |
