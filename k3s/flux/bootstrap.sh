#!/bin/bash
# Rebuild everything in the cluster from git: run once on a fresh k3s (or again on a live one: every step is idempotent).
# Needs: kubectl on the new cluster, the age private key (Bitwarden). Then Flux installs the rest from GitHub.
# usage: k3s/flux/bootstrap.sh <age key file>
set -euo pipefail
key=${1:?usage: $0 <age key file>}
[ -r "$key" ] || { echo "cannot read $key"; exit 1; }
grep -q '^AGE-SECRET-KEY-' "$key" || { echo "$key is not an age private key"; exit 1; }
cd "$(dirname "$0")"

echo "Cluster: $(kubectl config current-context) ($(kubectl get nodes --no-headers | wc -l | tr -d ' ') nodes)"
read -rp "Bootstrap Flux on this cluster? [y/N] " ok; [ "$ok" = y ] || exit 1

step() { echo; echo "== $*"; }

step "namespace and SOPS key"
kubectl apply -f namespace.yaml
kubectl -n flux-system create secret generic sops-age --from-file=age.agekey="$key" --dry-run=client -o yaml | kubectl apply -f -

step "Flux Operator (k3s Helm controller)"
kubectl apply -f helm-flux-operator.yaml
until kubectl get crd fluxinstances.fluxcd.controlplane.io >/dev/null 2>&1; do sleep 5; done
kubectl -n flux-system rollout status deployment/flux-operator --timeout=5m

step "Flux"
kubectl apply -f fluxinstance-flux.yaml
kubectl -n flux-system wait fluxinstance/flux --for=condition=Ready --timeout=10m

step "git source and root Kustomization"
kubectl apply -f sources/gitrepository-homelab.yaml -f k3s/kustomization-flux.yaml
kubectl -n flux-system wait gitrepository/homelab --for=condition=Ready --timeout=5m
kubectl -n flux-system wait kustomization/flux --for=condition=Ready --timeout=10m

step "everything else (apps restart a few times while their dependencies come up)"
sleep 30   # let the root Kustomization create the others
if ! kubectl -n flux-system wait kustomizations --all --for=condition=Ready --timeout=30m; then
  echo; echo "Not all Ready yet, Flux keeps retrying. Check: flux get kustomizations; flux get helmreleases -A"
  exit 1
fi
echo; echo "Done."
