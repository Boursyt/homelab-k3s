# Platform

One Flux `Kustomization` per directory of `k3s/`.

| File | Content |
|---|---|
| `kustomization-backup.yaml` | `k3s/backup`, after databases, nfs |
| `kustomization-cert-manager.yaml` | `k3s/cert-manager` |
| `kustomization-databases.yaml` | `k3s/databases` |
| `kustomization-devices.yaml` | `k3s/devices` |
| `kustomization-flux.yaml` | `k3s/flux` |
| `kustomization-grafana.yaml` | `k3s/grafana`, after databases, metrics |
| `kustomization-kube-vip.yaml` | `k3s/kube-vip` |
| `kustomization-metrics.yaml` | `k3s/metrics` |
| `kustomization-nfs.yaml` | `k3s/nfs` |
| `kustomization-system-upgrade.yaml` | `k3s/system-upgrade` |
| `kustomization-traefik.yaml` | `k3s/traefik` |
