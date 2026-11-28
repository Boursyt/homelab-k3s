# GitLab CI

`.gitlab-ci.yml` at the root only sets the rules and includes `ci/*.yml`.
Project CI/CD variables: `GITLAB_COM_TOKEN` (gitlab.com project token, `write_repository`, Maintainer), `MERGE_TOKEN` (project access token, api, Maintainer), `RENOVATE_TOKEN` (api, write_repository), `RENOVATE_GITHUB_COM_TOKEN`. Schedule: daily at 04:00 UTC.

| File | Content |
|---|---|
| `ci/validate.yml` | on every MR: `gitleaks`, `render` (`scripts/validate.sh`), `kubeconform` on `rendered/` |
| `ci/merge.yml` | auto-merge once validated, except `renovate/manual-*` branches. Squash for human branches; Renovate branches keep their own commit (authored with the owner's address, see `gitAuthor`). The merge commit carries a `Co-authored-by` trailer of the owner so it counts in the GitHub contribution graph |
| `ci/publish.yml` | after every push to `main` (a merge): pushes `main` to gitlab.com right away (fast-forward only, token `GITLAB_COM_TOKEN` = protected + masked CI variable) instead of waiting for GitLab's own push mirror (2–4 min), which stays as a fallback. Only on `git.lab`: the mirror copies this file to gitlab.com, which must not run it |
| `ci/renovate.yml` | scheduled Renovate run (config `renovate.json`) |
| `renovate.json` | Renovate config. Its commits are signed with the owner's GitHub noreply address (`gitAuthor`) so they count in the GitHub contribution graph through the mirror chain. Major updates and `iac/` get a `renovate/manual-` branch (merge by hand). `off-cluster/trident/`, `off-cluster/dns/` and `k3s/nodes/` are skipped. NAS stacks (`off-cluster/kibisis/`) are updated with pinned digests; PostgreSQL and PgBouncer always get a `manual-` branch |
| `scripts/validate.sh` | renders each Flux Kustomization with `flux build --dry-run` into `rendered/` |
