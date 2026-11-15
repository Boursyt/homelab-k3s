# doco-cd

Deploys the NAS stacks from git: every 3 minutes it reads `main` of the public GitLab.com mirror (no token) and applies `.doco-cd.nas.yml` (target `nas`).
Encrypted `secrets.env` files are decrypted with the NAS age key `/volume2/stacks/doco-cd/age.agekey` (600, root, copy in Bitwarden). It is not the cluster key.
Compose project names in `.doco-cd.nas.yml` must stay equal to the folder names, so the existing containers are adopted.
Everything merged on `main` is applied, including PostgreSQL and PgBouncer: the gate is the MR (Renovate branches `renovate/manual-*` for those two are merged by hand). Merging a change to a database stack restarts it.
Bind mounts of data and secrets use absolute `/volume2/stacks/<stack>/...` paths; files from git can stay relative.

| File | Content |
|---|---|
| `compose.yaml` | doco-cd container (Docker socket, data folder, age key, health on 192.168.1.210:9180). Update by hand: `docker compose up -d` in `/volume2/stacks/doco-cd` |
