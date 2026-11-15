# doco-cd (trident)

Deploys the Docker stacks of this VPS from git: every 3 minutes it reads `main` of the public GitLab.com mirror (no token) and applies `.doco-cd.trident.yml` (target `trident`). Same tool as on the NAS, with no secrets here (the nginx stack has none).
It holds the Docker socket, so it is root-equivalent on this host: it only reads this repository, whose `main` is protected (merge request + pipeline).
Only Docker stacks are deployed this way. The firewall, the WireGuard failover timer and the sysctl are host files, still installed by hand (see the parent README).

| File | Content |
|---|---|
| `compose.yaml` | doco-cd container (Docker socket, data folder). Update by hand: `docker compose up -d` in `~/doco-cd` |
