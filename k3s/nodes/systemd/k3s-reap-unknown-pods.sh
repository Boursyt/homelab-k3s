#!/bin/sh
# Delete pods stuck in Unknown on this node after a reboot (their controller recreates them).
set -eu

NODE=$(hostname)

k3s kubectl get pods -A \
  --field-selector "status.phase=Unknown,spec.nodeName=${NODE}" \
  -o jsonpath='{range .items[*]}{.metadata.namespace} {.metadata.name}{"\n"}{end}' |
while read -r ns name; do
  [ -n "${name}" ] || continue
  echo "Unknown pod on ${NODE}: deleting ${ns}/${name}"
  k3s kubectl delete pod -n "${ns}" "${name}" --wait=false
done
