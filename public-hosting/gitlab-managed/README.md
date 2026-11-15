# GitLab managed runners

Runners for the projects of gitlab.com (managed), nothing else in this namespace. Kubernetes executor, one pod per job.
amd64 (OptiPlex): 2 runner pods x 3 jobs. arm64 (Pis): 1 runner pod x 3 jobs. The runner pods themselves run on the OptiPlex.

Nothing is exposed: runners poll gitlab.com over outbound HTTPS, gitlab.com never calls them.
NetworkPolicy: DNS, the Kubernetes API (for the runner) and the internet only, never the cluster, the LAN or the VPN.

Runner tokens (one per runner, created in gitlab.com: Settings, CI/CD, Runners, New project runner) are SOPS Secrets, `gitlab-managed-runner-amd64` and `-arm64`.
gitlab.com has no runner for a personal namespace: the project runner is shared by unticking "Locked to current project" and enabling it in each other project
(Settings, CI/CD, Runners, "Other available project runners"). A group (projects moved into it) would give a group runner for all of them.
Tags: `amd64` (also runs untagged jobs) and `arm64` (`tags: [arm64]` in the pipeline).

    pbpaste | kubectl create secret generic gitlab-managed-runner-<arch> -n gitlab-managed --from-file=runner-token=/dev/stdin --dry-run=client -o yaml > secret-gitlab-managed-runner-<arch>.sops.yaml && sops -e -i secret-gitlab-managed-runner-<arch>.sops.yaml

| File | Content |
|---|---|
| `namespace.yaml` | `gitlab-managed` namespace |
| `helmrelease-gitlab-runner-amd64.yaml` | GitLab Runner chart, https://gitlab.com, amd64 jobs |
| `helmrelease-gitlab-runner-arm64.yaml` | same, jobs on the arm64 nodes |
| `networkpolicy-gitlab-managed.yaml` | egress: DNS, Kubernetes API, internet only |
| `secret-gitlab-managed-runner-amd64.sops.yaml`, `-arm64` | runner authentication tokens (SOPS) |
