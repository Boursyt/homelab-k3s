# GitLab

Self-hosted GitLab (planned). Only the storage is here for now: Gitaly needs a local-semantics disk, so it uses an iSCSI LUN of the NAS (target `gitlab`, CHAP, one session at a time).

| File | Content |
|---|---|
| `namespace.yaml` | `gitlab` namespace |
| `pv-iscsi-gitlab-gitaly.yaml` | static iSCSI PV (NAS LUN 0, ext4, no storage class provisioner) |
| `pvc-repo-data-gitlab-gitaly-0.yaml` | claim bound to that PV, named as the Gitaly StatefulSet expects |
| `secret-gitlab-iscsi-chap.sops.yaml` | CHAP credentials of the target (SOPS) |
| `secret-gitlab-object-storage.sops.yaml` | Garage S3 key for GitLab (object store connection + backups s3cfg), SOPS |
| `secret-gitlab-db.sops.yaml` | password of the `gitlab` role (NAS Postgres, database `gitlab`) |
| `deployment-valkey.yaml` | Valkey for GitLab (password, AOF on the NAS, no eviction) |
| `service-valkey.yaml` | Valkey Service |
| `pv-nfs-gitlab-valkey.yaml` | static NFS PV (`/volume2/k3s/gitlab/valkey`) |
| `pvc-valkey.yaml` | claim of the Valkey data |
| `secret-gitlab-valkey.sops.yaml` | Valkey password (SOPS) |
| `secret-gitlab-initial-root-password.sops.yaml` | initial password of the `root` administrator (rename the account after the first login), SOPS |
| `helmrelease-gitlab.yaml` | GitLab chart 10.5.6 (external Postgres, Valkey and S3; Traefik; OptiPlex only; SSH on the VIP, port 2223) |
| `namespace-gitlab-runner.yaml` | `gitlab-runner` namespace (runner managers and CI job pods) |
| `helmrelease-gitlab-runner-amd64.yaml` | amd64 runners, 6 jobs (draft, not in `kustomization.yaml` until the runner token Secret exists) |
| `helmrelease-gitlab-runner-arm64.yaml` | arm64 runners, 4 jobs (same) |

## Deployment process note

# zero downtine upgrade
https://docs.gitlab.com/charts/installation/
https://docs.gitlab.com/charts/installation/#zero-downtime-upgrades
https://docs.gitlab.com/charts/installation/upgrade/#recommended-deployment-settings

