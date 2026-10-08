# Flux

GitOps: Flux applies this repository to the cluster, reading the public GitHub mirror.

| File | Content |
|---|---|
| `namespace.yaml` | `flux-system` namespace |
| `helm-flux.yaml` | Flux (source, kustomize and notification controllers), installed by the k3s Helm controller |
| `gitrepository-homelab.yaml` | this repository, `main`, polled every minute |
| `kustomization-<name>.yaml` | one per directory of `k3s/`, `private-hosting/`, `public-hosting/`, with its dependencies |
| `kustomization.yaml` | the directories handed over to Flux so far |

A directory is handed over by listing its `kustomization-<name>.yaml` in `kustomization.yaml`, after `flux diff kustomization <name> --path ./<dir>` shows no change.
`prune` stays `false` until `flux tree kustomization <name>` has been checked. Not managed by Flux: `k3s/nodes/` and `off-cluster/`.

    kubectl apply --server-side -k k3s/flux   # first install only; then Flux applies this directory itself
    flux get kustomizations
    flux reconcile kustomization <name> --with-source
