# Gitea

| File | Content |
|---|---|
| `workflows/validate.yaml` | every PR to `main`: gitleaks, `flux build` of each Flux Kustomization validated by kubeconform, then squash-merge. Runs on the in-cluster Gitea runner, without access to the cluster |
| `validate.sh` | renders each Flux Kustomization with `flux build --dry-run` into `rendered/` (used by the workflow) |
