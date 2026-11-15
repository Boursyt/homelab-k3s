#!/bin/bash
# Render every Flux Kustomization of k3s/flux/ into rendered/, offline (no cluster).
set -euo pipefail
mkdir -p rendered
for f in k3s/flux/*/kustomization-*.yaml; do
  name=$(sed -n 's/^  name: //p' "$f" | head -1)
  path=$(sed -n 's/^  path: //p' "$f")
  flux build kustomization "$name" --path "$path" --kustomization-file "$f" --dry-run > "rendered/$name.yaml"
  echo "$name: $(grep -c '^kind:' "rendered/$name.yaml") objects"
done
