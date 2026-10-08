# system-upgrade

Automatic k3s upgrades on the stable channel, Sunday 04:30-06:00, one node at a time. Controller manifests are the upstream release files.

| File | Content |
|---|---|
| `plan-k3s-server.yaml` | upgrade plan of the servers |
| `plan-k3s-agent.yaml` | upgrade plan of the agents, after the servers |
| `crd-plans.yaml` | Plan CRD |
| `namespace.yaml` | `system-upgrade` namespace |
| `deployment-system-upgrade-controller.yaml` | controller |
| `configmap-default-controller-env.yaml` | controller settings |
| `serviceaccount-system-upgrade.yaml` | account of the controller and upgrade jobs |
| `role-*.yaml, clusterrole-*.yaml, rolebinding-*.yaml, clusterrolebinding-*.yaml` | permissions |
