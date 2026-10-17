# k3s nodes

Files installed on the nodes (not applied by Flux). Servers: the 3 OptiPlex; agents: the 4 Pis.

| File | Content |
|---|---|
| `config-labrys.yaml`, `config-doru.yaml`, `config-xiphos.yaml` | `/etc/rancher/k3s/config.yaml` of the servers (OptiPlex, embedded etcd, snapshots to GCS) |
| `config-aegis.yaml`, `config-keraunos.yaml`, `config-bident.yaml`, `config-harpe.yaml` | `/etc/rancher/k3s/config.yaml` of the agents (Pis) |
| `systemd/reap-unknown-pods.*` | deletes pods left by a reboot (Unknown, or Failed before a device plugin was ready), on all nodes (every server) |

Install: `curl -sfL https://get.k3s.io | sudo INSTALL_K3S_VERSION=<cluster version> sh -s - server` (or `agent`), after copying the config and `/etc/rancher/k3s/cluster-token`.
