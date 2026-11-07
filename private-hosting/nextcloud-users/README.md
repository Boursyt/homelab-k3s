# Nextcloud users

Private page (users.lab) to manage who may sign in to Nextcloud (cloud.lab.pub): allow a Google account, disable, delete, set its quota.
Allowed accounts are created through the `user_oidc` pre-provisioning API, so they have no password and can only sign in with Google.
No authentication: reachable from the LAN and the VPN only.

| File | Content |
|---|---|
| `namespace.yaml` | `nextcloud-users` namespace, Pod Security `restricted` |
| `app.py` | the app: Python standard library only, talks to Nextcloud's OCS API inside the cluster |
| `deployment-nextcloud-users.yaml` | `python` image running `app.py` from the ConfigMap, read-only, as nobody |
| `service-nextcloud-users.yaml` | Service |
| `ingress-nextcloud-users.yaml` | `users.lab.theoboursy.fr` |
| `networkpolicy-nextcloud-users.yaml` | in: Traefik; out: DNS and Nextcloud |
| `secret-nextcloud-admin.sops.yaml` | password of the Nextcloud `admin` account (copy of `public-hosting/nextcloud/secret-nextcloud-admin.sops.yaml`: change both together), encrypted with SOPS. Not an app password: Nextcloud requires a password confirmation to edit or delete users |

The local `admin` account (break-glass) is shown but cannot be changed here.
