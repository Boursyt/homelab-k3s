# Glance config

Glance dashboard, one file per block.

| File | Content |
|---|---|
| `glance.yml` | server, branding, custom CSS (readable text, brighter secondary colour, `.tbl` grid tables, status pills, Latte overrides), theme following the device mode, 30 s auto-refresh, page includes |
| `theme.yml` | Catppuccin Mocha (dark, contrast 1.45) and Latte (light, `default-light`); picker hidden |
| `homelab.yml` | page Homelab, kept light: machines, k3s, NAS, printer, launcher and global states |
| `page-storage.yml`, `page-network.yml`, `page-git.yml`, `page-apps.yml` | the other four pages |
| `hardware.yml`, `k3s.yml`, `nas.yml`, `printer.yml`, `apps.yml`, `public.yml`, `status.yml`, `speedtest.yml` | Homelab blocks (launcher: every private Gatus check with an `href` label, grouped by `section`, sorted by `order`) |
| `backups.yml` | global backup state: green, orange when some are older than 26 h (or never ran), red when half or more are |
| `databases.yml` | global state of the 3 Postgres stacks (primary, replica, PgBouncer, lag, connections) |
| `network-mini.yml` | compact probes for Homelab |
| `backups-detail.yml`, `valkey.yml`, `pvc.yml` | Storage: every backup, the 4 Valkey caches, PVC usage |
| `db-private.yml`, `db-public.yml`, `db-gitlab.yml` | Storage: detail of each Postgres stack, same query with another `stack` label |
| `garage.yml` | Storage: Garage S3 (admin API with `GARAGE_ADMIN_TOKEN`, Secret `garage-admin`): status, free space, objects and size of each of the 12 buckets |
| `network.yml`, `net-dns.yml`, `net-certs.yml`, `net-latency.yml`, `ingress.yml`, `traffic.yml` | Network: probes, CoreDNS, certificate expiry, slowest checks, Traefik (private / public entrypoints), traffic and errors per node |
| `git-mrs.yml`, `git-merged.yml`, `git-pipelines.yml`, `git-mirrors.yml`, `git-gitlab.yml`, `git-gitops.yml`, `doco-cd.yml` | Git: open and merged MRs (`renovate/manual-*` highlighted), pipelines and Renovate last run, gitlab.com / GitHub mirror check, GitLab pods and Gitaly volume, Flux objects and doco-cd (metrics of the NAS instance). Read-only GitLab token `GITLAB_TOKEN` (Secret `gitlab-token`, project token `glance (read only)`, Reporter, `read_api`, expires ~2027-11) |
| `apps-namespaces.yml`, `apps-nodes.yml`, `apps-problems.yml`, `apps-traffic.yml` | Apps: memory / CPU / restarts and nodes per namespace, what runs on each node, cluster problems, Traefik traffic per service |
