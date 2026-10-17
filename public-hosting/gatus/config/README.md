# Config

| File | Content |
|---|---|
| `base.yaml` | storage (public PostgreSQL), metrics, ntfy alerting, UI in the colours and fonts of theoboursy.fr |
| `homelab.yaml` | public dashboard and this status page through their public URL (TLS, certificate), public database, every minute |
| `projects.yaml` | Cloud Run projects, every 3 h (they scale to zero) |

Checks with `href` + `desc` labels are listed in the PUBLIC part of the public Glance (and `icon` + `order` in the private Glance Public block).
