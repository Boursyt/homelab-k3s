# Glance

Homelab dashboard (lab.theoboursy.fr).

| File | Content |
|---|---|
| `config/` | Glance config, one file per block; `glance.yml` has the custom CSS and the 30 s auto-refresh |
| `namespace.yaml` | `glance` namespace |
| `deployment-glance.yaml` | Glance, 2 replicas on different nodes |
| `pdb-glance.yaml` | keeps one replica during node drains |
| `service-glance.yaml` | Service |
| `ingress-glance.yaml` | `lab.theoboursy.fr` |
