# Garage

S3-compatible object storage for GitLab (artifacts, LFS, uploads, packages, backups). Single node, path-style, LAN only (`192.168.1.210:3900`).
Secrets (`GARAGE_RPC_SECRET`, `GARAGE_ADMIN_TOKEN`) are in `secrets.env` (SOPS). Metadata in `/volume2/stacks/garage/meta` (NVMe), data in `/volume1/garage`.

| File | Content |
|---|---|
| `compose.yaml` | Garage container |
| `garage.toml` | node config without secrets |
