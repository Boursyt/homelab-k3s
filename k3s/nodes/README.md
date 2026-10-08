# k3s nodes

Files installed on the Pis.

| File | Content |
|---|---|
| `config-aegis.yaml, config-keraunos.yaml, config-bident.yaml` | `/etc/rancher/k3s/config.yaml` of the servers (embedded etcd, snapshots to GCS) |
| `config-harpe.yaml` | `/etc/rancher/k3s/config.yaml` of the agent |
| `systemd/k3s-reap-unknown-pods.*` | deletes pods stuck in Unknown after a reboot (every server) |
