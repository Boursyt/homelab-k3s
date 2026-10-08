# homelab

Configuration of my homelab: a k3s cluster on Raspberry Pis, a NAS for data, a VPS as VPN hub and future public entry point.

## Hardware

| Host | Role |
|---|---|
| aegis, keraunos | Raspberry Pi 5 8 GB — k3s servers (embedded etcd) |
| bident | Raspberry Pi 4 8 GB — k3s server (embedded etcd) |
| harpe | Raspberry Pi 4 4 GB — k3s agent |
| kibisis | Ugreen DXP2800 NAS — PostgreSQL (primary + replica + PgBouncer), VictoriaMetrics, NFS |
| trident | VPS — WireGuard hub, future public reverse proxy |

The NAS stores data, the Pis run compute.

## Layout

| Path | Content |
|---|---|
| `k3s/` | the cluster itself: VIP, ingress, TLS, storage, upgrades, backups, metrics, Grafana, node configs |
| `private-hosting/` | services for the home network and VPN only, on `*.lab.theoboursy.fr` |
| `public-hosting/` | services exposed on the internet, on `*.lab.pub.theoboursy.fr` |
| `off-cluster/` | machines outside Kubernetes: NAS stacks, VPS |

Flux applies everything from this repository (`k3s/flux/`): push to `main`, the cluster follows within a minute.

- own apps: plain Kustomize directories, one object per file named `<kind>-<name>.yaml`
- third-party software: a Flux `HelmRelease` (`helmrelease-*.yaml`, chart version pinned, values inline) in its directory
- every directory has a README describing its files

## Notes

- Secrets are created with `kubectl create secret` and never committed; manifests only reference them by name.
- Files under `off-cluster/` and `k3s/nodes/` are copies of files on the machines: copy them back after editing.
