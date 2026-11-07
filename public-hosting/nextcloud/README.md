# Nextcloud

Personal cloud (cloud.lab.pub), public. Sign-in with Google only, for pre-provisioned users. Database in the public NAS Postgres.

| File | Content |
|---|---|
| `namespace.yaml` | `nextcloud` namespace, Pod Security `restricted` |
| `pv-nfs-nextcloud-nextcloud-html.yaml` | NFS volume on the NAS (`/volume2/k3s/nextcloud/nextcloud-html`): code, config, apps |
| `pv-nfs-nextcloud-nextcloud-data.yaml` | NFS volume on the NAS (`/volume1/nextcloud`, HDD, UGOS quota 300 GB): user files |
| `pvc-nextcloud-html.yaml`, `pvc-nextcloud-data.yaml` | claims for the volumes above |
| `helmrelease-nextcloud.yaml` | chart `nextcloud`: php-fpm + nginx + Valkey + cron sidecars, all as uid 1000 |
| `ingress-nextcloud.yaml` | `cloud.lab.pub.theoboursy.fr` (public entrypoint) |
| `networkpolicy-nextcloud.yaml` | in: Traefik; out: DNS, NAS Postgres, internet 443 |
| `secret-nextcloud-admin.sops.yaml`, `secret-nextcloud-db.sops.yaml` | Secrets encrypted with SOPS (see the root README) |

Users: `user_oidc` with `auto_provision` off, so only accounts created beforehand can sign in (50 GB quota each).
Allow someone: `.helpers/nextcloud-allow.sh <email> [--admin]` (Mac). Local admin login: `/login?direct=1`.
The Google OAuth client (`secret-nextcloud-oidc`) is made by hand in the GCP console.
