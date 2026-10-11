# Traefik

Traefik, the ingress controller. Was the Traefik bundled with k3s; it is now a Flux HelmRelease (k3s runs with
`disable: [traefik]`), with the same values and the same image, so nothing k3s-specific is needed to rebuild it.

| File | Content |
|---|---|
| `helmrelease-traefik.yaml` | chart `traefik/traefik`, 2 replicas, HTTPS redirect, metrics, dashboard, entrypoints |

Entrypoints on the VIP: `web` (80) and `websecure` (443) are the defaults, used by every Ingress without annotation (private services).
`websecure-pub` (8443) is the only target of the public reverse proxy on trident; public Ingresses opt in with
`traefik.ingress.kubernetes.io/router.entrypoints: websecure-pub`. A public SNI with a private `Host` header therefore finds no router.

The Gateway API CRDs installed by the k3s `traefik-crd` chart are still in the cluster but not in git (nothing uses them).
