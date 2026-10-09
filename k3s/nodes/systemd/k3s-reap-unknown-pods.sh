#!/bin/sh
# Delete pods left behind by a reboot (their controller recreates them), on every node:
# - phase Unknown;
# - phase Failed with reason UnexpectedAdmissionError (started before a device plugin was ready).
# Runs on each server; deleting an already deleted pod is ignored.
set -eu

k3s kubectl get pods -A --field-selector status.phase!=Running,status.phase!=Succeeded,status.phase!=Pending \
  -o jsonpath='{range .items[*]}{.metadata.namespace} {.metadata.name} {.status.phase} {.status.reason}{"\n"}{end}' |
while read -r ns name phase reason; do
  [ -n "${name}" ] || continue
  case "${phase}/${reason:-}" in
    Unknown/*|Failed/UnexpectedAdmissionError) ;;
    *) continue ;;
  esac
  echo "${phase} ${reason:-} pod: deleting ${ns}/${name}"
  k3s kubectl delete pod -n "${ns}" "${name}" --wait=false --ignore-not-found
done
