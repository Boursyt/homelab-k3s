# Gatus

Status page with uptime checks of every app, service, node and host (status.lab).

| File | Content |
|---|---|
| `config/` | checks, one file per section, merged by Gatus |
| `deployment-gatus.yaml` | Gatus, history in the NAS Postgres |
| `service-gatus.yaml` | Service |
| `ingress-gatus.yaml` | `status.lab.theoboursy.fr` |
| `serviceaccount-gatus.yaml` | account used to check the Kubernetes API health |
| `secret-gatus-k8s-token.yaml` | token of that account |

Every check alerts on ntfy.sh (3 failures in a row, resolution after 2 successes). The topic is a secret: Secret `gatus-ntfy` (`topic`), not committed.
