# Reap timer

Installed on every k3s server.

| File | Content |
|---|---|
| `k3s-reap-unknown-pods.sh` | deletes pods left by a reboot, on all nodes (`/usr/local/bin/`) |
| `k3s-reap-unknown-pods.service` | runs the script |
| `k3s-reap-unknown-pods.timer` | schedule |
