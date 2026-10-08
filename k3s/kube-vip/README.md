# kube-vip

Virtual IP 192.168.1.200 for the Kubernetes API, held by one server at a time.

| File | Content |
|---|---|
| `daemonset-kube-vip-ds.yaml` | kube-vip on every control-plane node |
| `serviceaccount-kube-vip.yaml` | account |
| `clusterrole-system-kube-vip-role.yaml` | permissions (leases, services, nodes) |
| `clusterrolebinding-system-kube-vip-binding.yaml` | binding |
