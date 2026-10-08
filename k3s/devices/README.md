# Devices

Host devices exposed as Kubernetes resources, so that pods using them need no privileged mode.

| File | Content |
|---|---|
| `daemonset-generic-device-plugin.yaml` | on aegis: the Zigbee USB dongle as resource `homelab/zigbee`, mounted at `/dev/zigbee` |

A pod asks for it with `resources.limits: { homelab/zigbee: 1 }` and joins group `dialout` (20) to open it.
