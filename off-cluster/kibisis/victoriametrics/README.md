# VictoriaMetrics

Long-term metrics store, 12 months.

| File | Content |
|---|---|
| `compose.yaml` | VictoriaMetrics with basic auth |

Runs as nobody (65534, owner of `data/`), read-only, without capabilities.
