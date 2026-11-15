# iac

Terraform for the GCP side of the homelab: lab DNS records, buckets, service accounts.
The zone itself belongs to the `theoboursy_fr` repository. Service account keys are not managed here.

| File | Content |
|---|---|
| `versions.tf` | Terraform and Google provider versions (state in a GCS bucket) |
| `variables.tf` | projects, region, DNS zone, VIP and VPS addresses |
| `dns.tf` | the `lab` and `lab.pub` A records in the existing zone |
| `storage.tf` | the k3s backup bucket and the Terraform state bucket |
| `iam.tf` | `k3s-backup` and cert-manager DNS service accounts and their roles |

    terraform init && terraform plan
