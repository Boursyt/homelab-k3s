# Firewall

Inbound filter of trident: only SSH, HTTP/HTTPS (nginx) and WireGuard from the internet; everything from the VPN.

| File | Content |
|---|---|
| `hostfw.nft` | nftables table `inet hostfw`, input policy drop |
| `hostfw.service` | loads it at boot, before the network |

The table is separate on purpose: Debian's `nftables.service` flushes the whole ruleset, which would also drop the Docker and WireGuard rules.

    sudo apt-get install -y nftables
    sudo install -D -m 644 hostfw.nft /etc/nftables.d/hostfw.nft
    sudo install -m 644 hostfw.service /etc/systemd/system/
    sudo systemctl daemon-reload && sudo systemctl enable --now hostfw
