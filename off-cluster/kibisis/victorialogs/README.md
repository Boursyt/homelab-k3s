# VictoriaLogs

Logs store for the cluster pods, 30 days. Fed by vlagent (`k3s/metrics/`), read by Grafana.

| File | Content |
|---|---|
| `compose.yaml` | VictoriaLogs with basic auth |

Runs as nobody (65534, owner of `/volume2/stacks/victorialogs/data`), read-only, without capabilities.
Credentials in `secrets.env` (SOPS), data on the NAS only.
