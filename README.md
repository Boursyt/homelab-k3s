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
| `iac/` | Terraform for GCP: DNS records, backup bucket, service accounts |

Changes go through a pull request on the self-hosted Gitea: `.gitea/workflows/validate.yaml` checks it (no secret,
every directory builds and is valid) and merges it. Gitea mirrors `main` to GitHub, and Flux (`k3s/flux/`) applies it within a minute.

    git switch -c my-change && git commit -am "…" && git push -u origin my-change   # then open the PR

- own apps: plain Kustomize directories, one object per file named `<kind>-<name>.yaml`
- third-party software: a Flux `HelmRelease` (`helmrelease-*.yaml`, chart version pinned, values inline) in its directory
- every directory has a README describing its files

## Rebuild from scratch

Everything in the cluster comes back from git; the data stays on the NAS (NFS volumes, PostgreSQL), so apps find it again.

1. Install k3s on the nodes with the configs in `k3s/nodes/` (first server with `cluster-init`, the others join it).
2. Get the age private key from Bitwarden into a file, then run `k3s/flux/bootstrap.sh <key file>`: it creates the
   `sops-age` Secret, installs the Flux Operator and Flux, and points Flux at this repository.
3. Flux installs the rest. Apps restart a few times while their dependencies come up (certificates, NFS, databases).
4. Delete the key file.

Outside the cluster (not rebuilt by this): the NAS (`off-cluster/kibisis/`, PostgreSQL roles and databases by hand),
the VPS (`off-cluster/trident/`), GCP (bucket, DNS), the router.

## Notes

- Secrets are committed encrypted with [SOPS](https://github.com/getsops/sops) + age (`secret-*.sops.yaml`, rules in `.sops.yaml`): only the values are encrypted, Flux decrypts them with the Secret `flux-system/sops-age`. The age private key is not in git: it is in Bitwarden and in `~/Library/Application Support/sops/age/keys.txt` on the Mac. Edit a Secret with `sops <file>`; add one with `kubectl create secret … --dry-run=client -o yaml > <dir>/secret-<name>.sops.yaml && sops -e -i <dir>/secret-<name>.sops.yaml`.
- Files under `off-cluster/` and `k3s/nodes/` are copies of files on the machines: copy them back after editing.
