# Reap timer

Installed on every k3s server.

| File | Content |
|---|---|
| `reap-unknown-pods.sh` | deletes pods left by a reboot, on all nodes (`/usr/local/bin/`) |
| `reap-unknown-pods.service` | runs the script |
| `reap-unknown-pods.timer` | schedule |

The unit names must not start with `k3s`: `k3s-uninstall.sh` then thinks another k3s is installed and keeps all its data.
