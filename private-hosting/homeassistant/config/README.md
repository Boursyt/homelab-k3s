# Home Assistant config

Files mounted read-only into `/config`; everything created in the UI lives on the volume.

| File | Content |
|---|---|
| `configuration.yaml` | core config: URLs, proxy, recorder on Postgres, Prometheus metrics of the plugs |
| `packages/spoolman_ams_sync.yaml` | assigns each AMS slot to its Spoolman spool |
| `packages/spoolman_deduct.yaml` | deducts the filament of each print from the spools |
