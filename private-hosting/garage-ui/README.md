# Garage UI

Web UI of the Garage S3 storage of the NAS (s3.lab). Talks to the admin API (`192.168.1.210:3903`) with the admin token; own login (`AUTH_USER_PASS`, bcrypt).

| File | Content |
|---|---|
| `namespace.yaml` | `garage-ui` namespace (PSA restricted) |
| `deployment-garage-ui.yaml` | Garage Web UI |
| `service-garage-ui.yaml` | Service |
| `ingress-garage-ui.yaml` | `s3.lab.theoboursy.fr` |
| `secret-garage-ui.sops.yaml` | admin token + UI login, encrypted with SOPS |
