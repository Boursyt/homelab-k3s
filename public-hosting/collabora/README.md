# Collabora

Collabora Online (CODE): the office suite behind Nextcloud Office (docs, sheets, slides), on office.lab.pub. Browsers load the editor from here; Nextcloud and Collabora exchange documents inside the cluster (WOPI).

| File | Content |
|---|---|
| `namespace.yaml` | `collabora` namespace, Pod Security `restricted` |
| `helmrelease-collabora.yaml` | chart `collabora-online`: 1 pod, uid 1001, no capabilities (so no chroot mounts), admin console off |
| `ingress-collabora.yaml` | `office.lab.pub.theoboursy.fr` (public entrypoint) |
| `ingress-collabora-convert.yaml` | `/cool/convert-to` closed from the internet (Nextcloud uses it inside the cluster) |
| `middleware-deny-all.yaml` | Traefik middleware used above |
| `networkpolicy-collabora.yaml` | in: Traefik, Nextcloud; out: DNS, Nextcloud |
| `secret-collabora-admin.sops.yaml` | admin user required by the chart (console disabled), encrypted with SOPS |
| `secret-collabora-proof-key.sops.yaml` | RSA proof key: Collabora signs its WOPI requests, Nextcloud checks them |

Nextcloud side (`public-hosting/nextcloud`, start hook): app `richdocuments`, `wopi_url` = Collabora Service, `public_wopi_url` = office.lab.pub, `wopi_callback_url` = Nextcloud Service, `wopi_allowlist` = pod network.
