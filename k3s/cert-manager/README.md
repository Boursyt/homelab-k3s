# cert-manager

TLS: two wildcard Let's Encrypt certificates (DNS-01 on Google Cloud DNS) used by Traefik.

| File | Content |
|---|---|
| `helm-cert-manager.yaml` | cert-manager chart |
| `clusterissuer-letsencrypt-prod.yaml` | Let's Encrypt production issuer |
| `clusterissuer-letsencrypt-staging.yaml` | Let's Encrypt staging issuer (tests) |
| `certificate-lab-wildcard.yaml` | `lab.theoboursy.fr` + `*.lab.theoboursy.fr` |
| `certificate-lab-pub-wildcard.yaml` | `lab.pub.theoboursy.fr` + `*.lab.pub.theoboursy.fr` (public services) |
| `tlsstore-default.yaml` | private wildcard as Traefik's default certificate, public one picked by SNI |

No ACME email: Let's Encrypt no longer sends expiry emails, and expiry is watched by Gatus (certificate older than 14 days before expiry = alert).
