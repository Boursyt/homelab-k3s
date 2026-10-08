# Gitea

Git server (git.lab) with an Actions runner. Repositories, runner and cache data on the NAS (NFS).

| File | Content |
|---|---|
| `namespace.yaml` | `gitea` namespace |
| `helmrelease-gitea.yaml` | Gitea chart (1 replica, Recreate, Valkey cache) |
| `helmrelease-gitea-runner.yaml` | Gitea Actions runner chart |
| `pv-nfs-gitea-gitea-shared-storage.yaml` | NFS volume of the repositories (`nocto`: single writer only) |
| `pvc-gitea-shared-storage.yaml` | claim for the volume above |
| `pv-nfs-gitea-valkey-data-gitea-valkey-cluster-0.yaml` | NFS volume of Valkey |
| `pvc-valkey-data-gitea-valkey-cluster-0.yaml` | claim for the volume above |
| `pv-nfs-gitea-data-act-runner-gitea-runner-actions-act-runner-0.yaml` | NFS volume of the runner |
| `pvc-data-act-runner-gitea-runner-actions-act-runner-0.yaml` | claim for the volume above |
