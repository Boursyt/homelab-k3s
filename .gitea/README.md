# Gitea

| File | Content |
|---|---|
| `workflows/validate.yaml` | every PR to `main`: gitleaks, `kubectl kustomize` + kubeconform on each directory, then squash-merge. Runs on the in-cluster Gitea runner |
