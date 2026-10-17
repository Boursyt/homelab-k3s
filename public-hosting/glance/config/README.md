# Config

| File | Content |
|---|---|
| `glance.yml` | server, branding, custom CSS, auto-refresh script |
| `theme.yml` | dark theme (default) and light preset |
| `homelab.yml` | page layout |
| `about.yml` | what this is + the repository card |
| `hosts.yml` | machines, uptime, state |
| `k3s.yml`, `nas.yml` | cluster and NAS usage |
| `network.yml`, `speedtest.yml`, `traffic.yml` | latency probes, internet speed, live traffic per host |
| `projects.yml` | Cloud Run projects, status of the last 3-hourly check |
| `services.yml` | public services (public Gatus checks with `href` + `desc` labels) and private apps (private Gatus checks with a `desc` label); icon from the `icon` label or the check name |
| `databases.yml` | public PostgreSQL: primary, replica, PgBouncer |
| `stack.yml` | software stack |
