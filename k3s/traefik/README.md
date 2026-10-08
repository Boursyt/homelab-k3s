# Traefik

Configuration of the Traefik bundled with k3s.

| File | Content |
|---|---|
| `helmchartconfig-traefik.yaml` | 2 replicas, HTTPS redirect, metrics, dashboard, entrypoints |

Entrypoints on the VIP: `web` (80) and `websecure` (443) are the defaults, used by every Ingress without annotation (private services).
`websecure-pub` (8443) is the only target of the public reverse proxy on trident; public Ingresses opt in with
`traefik.ingress.kubernetes.io/router.entrypoints: websecure-pub`. A public SNI with a private `Host` header therefore finds no router.
