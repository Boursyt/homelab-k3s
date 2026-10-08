# public-hosting

Services exposed on the internet, on `*.lab.pub.theoboursy.fr`, through the reverse proxy on trident.

Rules:

- only the front ends are public; backends (databases, VictoriaMetrics, APIs) stay private and are rendered server-side
- a dedicated PostgreSQL instance on the NAS, separate from the private one
- NetworkPolicies: a public pod only reaches its own database, DNS and what it explicitly needs
- a service is either private or public, never both
- public namespaces enforce Pod Security `restricted`: pods run non-root, read-only, without capabilities, with seccomp
- public Ingresses use only the Traefik entrypoint `websecure-pub` (annotation `traefik.ingress.kubernetes.io/router.entrypoints: websecure-pub`)

| Path | Content |
|---|---|
| `glance/` | public dashboard on `lab.pub.theoboursy.fr` |
| `gatus/` | public status page on `status.lab.pub.theoboursy.fr` |
