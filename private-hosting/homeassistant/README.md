# Home Assistant

Home automation (ha.lab). Host network for LAN discovery, history in the NAS Postgres, `/config` on NFS.

| File | Content |
|---|---|
| `config/configuration.yaml` | core configuration, mounted read-only |
| `config/packages/spoolman_ams_sync.yaml` | assigns each AMS slot to its Spoolman spool |
| `config/packages/spoolman_deduct.yaml` | deducts the filament of each print from the spools |
| `namespace.yaml` | `homeassistant` namespace |
| `pv-nfs-homeassistant-homeassistant-config.yaml` | NFS volume on the NAS (`/volume2/k3s/homeassistant/homeassistant-config`) |
| `pvc-homeassistant-config.yaml` | `/config` volume |
| `deployment-homeassistant.yaml` | Home Assistant |
| `service-homeassistant.yaml` | Service |
| `ingress-homeassistant.yaml` | `ha.lab.theoboursy.fr` |
| `secret-homeassistant-db.sops.yaml` | Secrets encrypted with SOPS (see the root README) |
