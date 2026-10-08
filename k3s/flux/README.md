# Flux

GitOps: Flux applies this repository to the cluster, reading the public GitHub mirror.
Own apps are plain Kustomize directories; third-party software is a Flux `HelmRelease` in its directory.

| Path | Content |
|---|---|
| `namespace.yaml` | `flux-system` namespace |
| `helm-flux.yaml` | Flux itself, installed by the k3s Helm controller (with Traefik, the only charts k3s installs) |
| `sources/` | this repository and the chart repositories |
| `k3s/`, `private-hosting/`, `public-hosting/` | one Flux `Kustomization` per directory of the same area, with its dependencies |

A new directory gets a `kustomization-<name>.yaml` in the matching folder. `prune` stays `false` until `flux tree kustomization <name>` has been checked.
Not managed by Flux: `k3s/nodes/` and `off-cluster/`.

## How to

**Change something** (any app or platform file): branch, push, open a PR on Gitea. The `validate` workflow checks and merges it,
Gitea mirrors `main` to GitHub, Flux applies within a minute.

    git switch -c my-change && git commit -am "…" && git push -u origin my-change
    flux reconcile kustomization <name> --with-source   # after the merge, to apply now

**Check the state**

    flux get kustomizations                 # one line per directory, Ready True/False
    flux get helmreleases -A                # the charts
    flux events --for Kustomization/<name>  # why it fails
    flux logs --level=error

**Add an own app**: create `private-hosting/<app>/` (or `public-hosting/`) with its `kustomization.yaml` and README,
then copy a `kustomization-*.yaml` here into the matching folder, change `name`, `path`, `dependsOn`, and list it in that folder's `kustomization.yaml`.

**Add a third-party chart**: a `helmrepository-<repo>.yaml` in `sources/` (if new) and a `helmrelease-<name>.yaml` in the app directory.

**Upgrade a chart**: change `version:` in its `helmrelease-*.yaml` and push. A failed upgrade is retried, then rolled back.

**Pause Flux on a directory** (to debug by hand), then resume, otherwise Flux undoes the manual changes:

    flux suspend kustomization <name>
    flux resume kustomization <name>

**Undo a change**: `git revert <commit>` and push.

**Remove something**: `prune` is `false`, so deleting a file does not delete the object: delete it with `kubectl delete` too.

**Secrets** are never in git: `kubectl create secret …` by hand, manifests only reference them.
