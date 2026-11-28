# trident

VPS outside the home network: WireGuard hub and public entry point (`nginx/`, forwards `*.lab.pub` to Traefik through the tunnel). Docker installed from Docker's apt repository.

WireGuard hub (10.8.0.1). Only the Traefik VIP (192.168.1.200/32) is reachable through aegis (primary) or keraunos (backup), not the whole LAN (a compromised hub cannot reach the NAS or the nodes);
WireGuard routes a prefix to one peer only, so `wg-lan-failover` moves it to the gateway that answers.

    sudo install -m 755 wg-lan-failover.sh /usr/local/bin/wg-lan-failover
    sudo install -m 644 wg-lan-failover.service wg-lan-failover.timer /etc/systemd/system/
    sudo systemctl daemon-reload && sudo systemctl enable --now wg-lan-failover.timer

| Path | Content |
|---|---|
| `wg-lan-failover.*` | moves the VIP route to the WireGuard gateway that answers |
| `nginx/` | public reverse proxy (TLS passthrough), deployed by doco-cd |
| `doco-cd/` | doco-cd: applies `.doco-cd.trident.yml` (the nginx stack) from git |
| `firewall/` | inbound filter: 22, 80, 443, WireGuard |
