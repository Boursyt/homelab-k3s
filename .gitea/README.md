# Gitea (legacy) and CI helpers

The CI is `.gitlab-ci.yml` at the root (self-hosted GitLab runners): `gitleaks`, `render` (`validate.sh`), `kubeconform`, then `merge` (auto-merge, squash, except `renovate/manual-*`), and a scheduled `renovate` job (config `renovate.json`).
CI/CD variables of the project: `MERGE_TOKEN` (project access token, api, Maintainer), `RENOVATE_TOKEN` (api, write_repository), `RENOVATE_GITHUB_COM_TOKEN`; schedule: daily at 04:00 UTC.
The Gitea workflows below only run while Gitea hosts the repository, they are kept for the backup and can be removed later. `validate.sh` and `renovate.json` are shared by both.

| File | Content |
|---|---|
| `workflows/validate.yaml` | every PR to `main`: gitleaks, `flux build` of each Flux Kustomization validated by kubeconform, then squash-merge (except `renovate/manual-*` branches). A PR behind `main` is first updated from `main`; the new run merges it. Runs on the in-cluster Gitea runner, without access to the cluster |
| `workflows/renovate.yaml` | every night (04:00 UTC): Renovate opens PRs for new chart, image, action and Terraform provider versions. Runs as `hypto` (secret `RENOVATE_TOKEN`), GitHub lookups with `RENOVATE_GITHUB_COM_TOKEN` |
| `renovate.json` | Renovate config. Major updates and `iac/` get a `renovate/manual-` branch: `validate` does not merge them, merge by hand. `off-cluster/` and `k3s/nodes/` are skipped |
| `validate.sh` | renders each Flux Kustomization with `flux build --dry-run` into `rendered/` (used by the workflow) |
