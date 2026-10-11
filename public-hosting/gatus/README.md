# Gatus (public)

Public status page (status.lab.pub.theoboursy.fr), separate from the private one: it only checks public things. History in the public PostgreSQL.

| File | Content |
|---|---|
| `config/` | Gatus config, merged from the directory |
| `namespace.yaml` | `gatus-public` namespace, Pod Security `restricted` enforced |
| `deployment-gatus.yaml` | Gatus, stateless |
| `service-gatus.yaml` | Service, also scraped for `/metrics` |
| `ingress-gatus.yaml` | `status.lab.pub.theoboursy.fr` |
| `networkpolicy-gatus.yaml` | in: Traefik, vmagent; out: DNS, public Postgres, internet on 443 (public services are checked through their public URL) |
| `secret-gatus-db.sops.yaml`, `secret-gatus-ntfy.sops.yaml` | Secrets encrypted with SOPS (see the root README) |

Secret (SOPS-encrypted): `gatus-db` (`username`, `password`), role `gatus` on the public PostgreSQL.

Every check alerts on ntfy.sh (3 failures in a row, resolution after 2 successes). The topic is a secret: Secret `gatus-ntfy` (`topic`), SOPS-encrypted.
