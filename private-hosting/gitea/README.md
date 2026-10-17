# Gitea

Git server (git.lab) with Actions runners. Repositories and Valkey data on the NAS (NFS); runners and their caches on the OptiPlex local disks.

| File | Content |
|---|---|
| `namespace.yaml` | `gitea` namespace |
| `helmrelease-gitea.yaml` | Gitea chart (1 replica, Recreate, Valkey cache) |
| `helmrelease-gitea-runner.yaml` | Gitea Actions runners: 3 (one per OptiPlex), 2 jobs each, persistent Docker + Actions cache; labels `ubuntu-latest`, `amd64` (all current workflows) |
| `helmrelease-gitea-runner-arm.yaml` | 2 arm64 runners (aegis, keraunos), 1 job each, label `arm64` only, ephemeral Docker data |
| `pv-nfs-gitea-gitea-shared-storage.yaml` | NFS volume of the repositories (`nocto`: single writer only) |
| `pvc-gitea-shared-storage.yaml` | claim for the volume above |
| `pv-nfs-gitea-valkey-data-gitea-valkey-cluster-0.yaml` | NFS volume of Valkey |
| `pvc-valkey-data-gitea-valkey-cluster-0.yaml` | claim for the volume above |
| `pvc-data-act-runner-gitea-runner-actions-act-runner-0.yaml` | claim for the volume above |
| `secret-gitea-admin-secret.sops.yaml`, `secret-gitea-db.sops.yaml`, `secret-gitea-runner-secret.sops.yaml` | Secrets encrypted with SOPS (see the root README) |
