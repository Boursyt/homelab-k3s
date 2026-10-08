# Manyfold

3D model library (manyfold.lab). Database in the NAS Postgres, files on the NAS HDD.

| File | Content |
|---|---|
| `namespace.yaml` | `manyfold` namespace |
| `pv-nfs-manyfold-models.yaml` | NFS volume of the models (`/volume1/models`, also shared over SMB) |
| `pvc-models.yaml` | claim for the volume above |
| `deployment-manyfold.yaml` | Manyfold (web + background workers) |
| `service-manyfold.yaml` | Service |
| `deployment-valkey.yaml` | job queue, in memory |
| `service-valkey.yaml` | Service |
| `ingress-manyfold.yaml` | `manyfold.lab.theoboursy.fr` |
