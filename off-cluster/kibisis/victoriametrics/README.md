# VictoriaMetrics

Long-term metrics store, 12 months.

| File | Content |
|---|---|
| `compose.yaml` | VictoriaMetrics with basic auth |

Runs as nobody (65534, owner of `/volume2/stacks/victoriametrics/data`), read-only, without capabilities.
Credentials in `secrets.env` (SOPS), data on the NAS only.
