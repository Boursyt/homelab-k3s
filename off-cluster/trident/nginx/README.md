# nginx

Public entry point of the homelab, in `~/nginx/` on trident. TLS is not terminated here: nginx reads the SNI and forwards the raw TLS stream to Traefik through WireGuard.

| File | Content |
|---|---|
| `compose.yaml` | nginx as uid 101, read-only, no capabilities, host network |
| `nginx.conf` | `stream` (443) and `http` (80) blocks |
| `stream.d/lab-pub.conf` | `lab.pub.theoboursy.fr` and `*.lab.pub.theoboursy.fr` → Traefik public entrypoint `192.168.1.200:8443`, everything else refused |
| `conf.d/redirect.conf` | port 80: redirect `*.lab.pub` to HTTPS, drop the rest |

Only the public entrypoint is reachable: a request with a public SNI but a private `Host` header finds no router there.

Host prerequisite (non-root process on ports 80/443):

    echo 'net.ipv4.ip_unprivileged_port_start = 80' | sudo tee /etc/sysctl.d/60-unprivileged-ports.conf
    sudo sysctl --system

    cd ~/nginx && docker compose up -d
