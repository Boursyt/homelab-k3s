# Nextcloud

Personal cloud (cloud.lab.pub), public. Sign-in with Google only, for pre-provisioned users. Database in the public NAS Postgres.

| File | Content |
|---|---|
| `namespace.yaml` | `nextcloud` namespace, Pod Security `restricted` |
| `pv-nfs-nextcloud-nextcloud-html.yaml` | NFS volume on the NAS (`/volume2/k3s/nextcloud/nextcloud-html`): config, apps, themes (the code is copied from the image to a per-pod emptyDir, so any node works) |
| `pv-nfs-nextcloud-nextcloud-data.yaml` | NFS volume on the NAS (`/volume1/nextcloud`, HDD, UGOS quota 300 GB): user files |
| `pvc-nextcloud-html.yaml`, `pvc-nextcloud-data.yaml` | claims for the volumes above |
| `helmrelease-nextcloud.yaml` | chart `nextcloud`: php-fpm + nginx + cron sidecar, all as uid 1000; a post-renderer moves `/var/www/html` to an emptyDir; RollingUpdate (no downtime on config changes) |
| `deployment-valkey.yaml`, `service-valkey.yaml` | Valkey shared by the Nextcloud pods: cache, file locks, sessions (memory only) |
| `ingress-nextcloud.yaml` | `cloud.lab.pub.theoboursy.fr` (public entrypoint) |
| `networkpolicy-nextcloud.yaml` | in: Traefik, `nextcloud-users`, Collabora; out: Collabora, DNS, NAS Postgres, internet 443 |
| `secret-nextcloud-admin.sops.yaml`, `secret-nextcloud-db.sops.yaml`, `secret-nextcloud-oidc.sops.yaml` | Secrets encrypted with SOPS (see the root README) |

Users: `user_oidc` with `auto_provision` off, so only accounts created beforehand can sign in (50 GB quota each).
Allow someone: https://users.lab.theoboursy.fr (`private-hosting/nextcloud-users`), or `.helpers/nextcloud-allow.sh <email> [--admin]` (Mac). Local admin login: `/login?direct=1`.
The Google OAuth client (`secret-nextcloud-oidc`) is made by hand in the GCP console (project `homelab-pi-510022`, Google Auth Platform: app "theoboursy cloud", home page and privacy policy on theoboursy.fr/cloud).
