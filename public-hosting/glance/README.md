# Glance (public)

Public dashboard (lab.pub.theoboursy.fr). Same base as the private one, with the colours of theoboursy.fr. Metrics are read through `vmauth-public` (query endpoints only), never directly from VictoriaMetrics.

| File | Content |
|---|---|
| `config/` | Glance config, one file per block; `glance.yml` has the custom CSS and the 30 s auto-refresh |
| `assets/` | favicon and fonts (Inter, JetBrains Mono), served by Glance: no third-party font requests |
| `namespace.yaml` | `glance-public` namespace, Pod Security `restricted` enforced |
| `deployment-glance.yaml` | Glance, 2 replicas on different nodes |
| `pdb-glance.yaml` | keeps one replica during node drains |
| `service-glance.yaml` | Service |
| `ingress-glance.yaml` | `lab.pub.theoboursy.fr` |
| `networkpolicy-glance.yaml` | in: Traefik only; out: DNS, vmauth-public, internet on 443 (no private ranges) |

Secret (not committed): `vmauth-public` (`username`, `password`).
