# Backups

Nightly backups of every Postgres database and of all app volumes, to the NAS and to GCS.

| File | Content |
|---|---|
| `namespace.yaml` | `backup` namespace |
| `pv-nfs-backup-backups-hdd.yaml` | NFS volume on the NAS HDD (`/volume1/backups`): dumps and restic repository |
| `pvc-backups-hdd.yaml` | claim for the volume above |
| `pv-nfs-backup-k3s-data-ro.yaml` | read-only NFS view of all app volumes (`/volume2/k3s`), source of restic |
| `pvc-k3s-data-ro.yaml` | claim for the volume above |
| `pv-nfs-backup-nextcloud-ro.yaml` | read-only NFS view of the Nextcloud files (`/volume1/nextcloud`, HDD) |
| `pvc-nextcloud-ro.yaml` | claim for the volume above |
| `cronjob-pg-dump.yaml` | 02:30: `pg_dump` of every database + globals of both instances (public one under `public/`), 14 days kept, success metric pushed to VictoriaMetrics |
| `cronjob-restic.yaml` | 03:30: restic backup of the app volumes, Nextcloud files (without preview cache) and dumps to the NAS, then copy to GCS |
| `secret-k3s-etcd-s3.sops.yaml`, `secret-postgres-admin.sops.yaml`, `secret-postgres-public-admin.sops.yaml`, `secret-restic.sops.yaml`, `secret-victoriametrics-auth.sops.yaml` | Secrets encrypted with SOPS (see the root README) |

`pg-dump` and `restic` run as root: UGOS ACLs deny every other uid on the backups share over NFS. `restic` because it reads every app's files, with only `DAC_READ_SEARCH` and read-only mounts.
