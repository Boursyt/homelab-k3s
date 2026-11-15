# private-hosting

Services reachable only from the home network and the VPN, on `*.lab.theoboursy.fr`.

| Path | Content |
|---|---|
| `gitlab/` | self-hosted GitLab (source of truth), its Valkey cache and storage |
| `gitea/` | old Git server, kept as a backup, with its Actions runners |
| `code-server/` | VS Code in the browser (code.lab) |
| `garage-ui/` | web UI of the NAS Garage S3 storage |
| `homeassistant/` | home automation |
| `zigbee/` | Zigbee2MQTT + Mosquitto |
| `glance/` | private homelab dashboard |
| `gatus/` | private status page |
| `openwebui/` | LLM chat |
| `spoolman/` | filament inventory |
| `manyfold/` | 3D model library |
| `nextcloud-users/` | who may sign in to Nextcloud (cloud.lab.pub) |
| `headlamp/` | Kubernetes web UI |
