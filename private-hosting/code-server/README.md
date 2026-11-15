# code-server

Self-hosted VS Code in the browser (code.lab), independent from the GitLab Web IDE. One user, password login. Extensions come from Open VSX, the registry the GitLab Web IDE uses too.
Home (projects, settings, extensions) on the NAS in `/volume2/k3s/code-server` (uid 1000). The init container installs the extensions of `configmap-extensions.yaml`, already installed ones are skipped.
Extensions of the Mac that are not there: not on Open VSX (Pylance, cpptools, Remote SSH/Containers/Explorer/Repositories, Live Share, Stream Deck, runonsave, tpl) or useless on a server (Discord, Codex audio, ESP-IDF, Docker/Containers: no Docker daemon). Pylance is replaced by basedpyright.

| File | Content |
|---|---|
| `namespace.yaml` | `code-server` namespace (PSA restricted) |
| `deployment-code-server.yaml` | code-server, init container for the extensions |
| `service-code-server.yaml` | Service |
| `ingress-code-server.yaml` | `code.lab.theoboursy.fr` |
| `configmap-extensions.yaml` | extensions to install |
| `pv-nfs-code-server-code-server.yaml`, `pvc-code-server.yaml` | NFS volume of the home |
| `secret-code-server.sops.yaml` | login password (SOPS) |
| `image/` | `Dockerfile` + `install-tools.sh`: code-server with Python (uv), Go, Terraform, kubectl, Helm, Flux, SOPS, age. To build and push to the GitLab registry (`registry.lab.theoboursy.fr`); the Deployment still uses the stock image until then |

The image is built by the GitLab CI of the project `boursyt/code-server` (copy `image/` there: Dockerfile, install-tools.sh, `.gitlab-ci.yml`, kaniko without privileges) and pushed to `registry.lab.theoboursy.fr/boursyt/code-server`.
