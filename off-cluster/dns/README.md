# DNS

Homelab records in the Google Cloud DNS zone `theoboursy` (project `theoboursy-fr`). They are not managed by the Terraform of the other `*.theoboursy.fr` sites: created with gcloud.

| Record | Type | Value | Use |
|---|---|---|---|
| `lab.theoboursy.fr` | A | 192.168.1.200 | private Glance (kube-vip VIP, home network + VPN only) |
| `*.lab.theoboursy.fr` | A | 192.168.1.200 | private services |
| `lab.pub.theoboursy.fr` | A | 92.222.85.53 | public Glance, through the reverse proxy on trident |
| `*.lab.pub.theoboursy.fr` | A | 92.222.85.53 | public services |

    gcloud dns record-sets create 'lab.pub.theoboursy.fr.' --zone=theoboursy --type=A --ttl=300 --rrdatas=92.222.85.53
    gcloud dns record-sets create '*.lab.pub.theoboursy.fr.' --zone=theoboursy --type=A --ttl=300 --rrdatas=92.222.85.53

TLS certificates use DNS-01 on the same zone (see `k3s/cert-manager`).
