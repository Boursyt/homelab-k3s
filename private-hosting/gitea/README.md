# Gitea

Git server (gitea.lab), **scaled to zero** since 2026-11-28: kept only as a dormant backup of the repositories (set `replicaCount` and the runners' `replicas` back to 1 to wake it; SSH is now ClusterIP only). Actions runners included. The CI now runs on GitLab: no workflow uses these runners any more. Repositories and Valkey data on the NAS (NFS); runners and their caches on the OptiPlex local disks.

| File | Content |
|---|---|
| `namespace.yaml` | `gitea` namespace |
| `helmrelease-gitea.yaml` | Gitea chart (1 replica, Recreate, Valkey cache) |
| `helmrelease-gitea-runner.yaml` | Gitea Actions runner: 1 on an OptiPlex, 1 job at a time, persistent Docker + Actions cache; labels `ubuntu-latest`, `amd64` |
| `helmrelease-gitea-runner-arm.yaml` | 1 arm64 runner (aegis or keraunos), 1 job at a time, label `arm64` only, ephemeral Docker data |
| `pv-nfs-gitea-gitea-shared-storage.yaml` | NFS volume of the repositories (`nocto`: single writer only) |
| `pvc-gitea-shared-storage.yaml` | claim for the volume above |
| `pv-nfs-gitea-valkey-data-gitea-valkey-cluster-0.yaml` | NFS volume of Valkey |
| `pvc-valkey-data-gitea-valkey-cluster-0.yaml` | claim for the volume above |
| `secret-gitea-admin-secret.sops.yaml`, `secret-gitea-db.sops.yaml`, `secret-gitea-runner-secret.sops.yaml` | Secrets encrypted with SOPS (see the root README) |
