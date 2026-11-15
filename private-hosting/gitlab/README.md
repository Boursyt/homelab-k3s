# GitLab

Self-hosted GitLab (planned). Only the storage is here for now: Gitaly needs a local-semantics disk, so it uses an iSCSI LUN of the NAS (target `gitlab`, CHAP, one session at a time).

| File | Content |
|---|---|
| `namespace.yaml` | `gitlab` namespace |
| `pv-iscsi-gitlab-gitaly.yaml` | static iSCSI PV (NAS LUN 0, ext4, no storage class provisioner) |
| `pvc-gitlab-gitaly.yaml` | claim bound to that PV |
| `secret-gitlab-iscsi-chap.sops.yaml` | CHAP credentials of the target (SOPS) |
| `secret-gitlab-object-storage.sops.yaml` | Garage S3 key for GitLab (object store connection + backups s3cfg), SOPS |
| `secret-gitlab-db.sops.yaml` | password of the `gitlab` role (NAS Postgres, database `gitlab`) |
| `deployment-valkey.yaml` | Valkey for GitLab (password, AOF on the NAS, no eviction) |
| `service-valkey.yaml` | Valkey Service |
| `pv-nfs-gitlab-valkey.yaml` | static NFS PV (`/volume2/k3s/gitlab/valkey`) |
| `pvc-valkey.yaml` | claim of the Valkey data |
| `secret-gitlab-valkey.sops.yaml` | Valkey password (SOPS) |
