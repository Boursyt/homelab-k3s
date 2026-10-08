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

Every service directory is a kustomization, applied the same way:

    kubectl apply --server-side -k <dir>

Helm charts are `HelmChart` objects (`helm-*.yaml`, version pinned, values inline) installed by the k3s Helm controller.
One object per file, named `<kind>-<name>.yaml`; each directory has a README describing its files.

## Notes

- Secrets are created with `kubectl create secret` and never committed; manifests only reference them by name.
- `k3s/cert-manager/acme.env` (not committed) holds the ACME email: `email=you@example.com`.
- Files under `off-cluster/` and `k3s/nodes/` are copies of files on the machines: copy them back after editing.
