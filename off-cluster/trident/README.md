# trident

VPS outside the home network: WireGuard hub and public entry point (`nginx/`, forwards `*.lab.pub` to Traefik through the tunnel). Docker installed from Docker's apt repository.

WireGuard hub (10.8.0.1). The home LAN is reachable through aegis (primary) or keraunos (backup);
WireGuard routes a prefix to one peer only, so `wg-lan-failover` moves 192.168.1.0/24 to the gateway that answers.

    sudo install -m 755 wg-lan-failover.sh /usr/local/bin/wg-lan-failover
    sudo install -m 644 wg-lan-failover.service wg-lan-failover.timer /etc/systemd/system/
    sudo systemctl daemon-reload && sudo systemctl enable --now wg-lan-failover.timer

| Path | Content |
|---|---|
| `wg-lan-failover.*` | moves the home LAN route to the WireGuard gateway that answers |
| `nginx/` | public reverse proxy (TLS passthrough) |
| `firewall/` | inbound filter: 22, 80, 443, WireGuard |
