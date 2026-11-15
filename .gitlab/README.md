# GitLab CI

`.gitlab-ci.yml` at the root only sets the rules and includes `ci/*.yml`.
Project CI/CD variables: `MERGE_TOKEN` (project access token, api, Maintainer), `RENOVATE_TOKEN` (api, write_repository), `RENOVATE_GITHUB_COM_TOKEN`. Schedule: daily at 04:00 UTC.

| File | Content |
|---|---|
| `ci/validate.yml` | on every MR: `gitleaks`, `render` (`scripts/validate.sh`), `kubeconform` on `rendered/` |
| `ci/merge.yml` | squash auto-merge once validated, except `renovate/manual-*` branches |
| `ci/renovate.yml` | scheduled Renovate run (config `renovate.json`) |
| `renovate.json` | Renovate config. Major updates and `iac/` get a `renovate/manual-` branch (merge by hand). `off-cluster/trident/`, `off-cluster/dns/` and `k3s/nodes/` are skipped. NAS stacks (`off-cluster/kibisis/`) are updated with pinned digests; PostgreSQL and PgBouncer always get a `manual-` branch |
| `scripts/validate.sh` | renders each Flux Kustomization with `flux build --dry-run` into `rendered/` |
