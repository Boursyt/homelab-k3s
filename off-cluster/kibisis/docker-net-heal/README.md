# docker-net-heal

At boot the NIC of the NAS loses its link for ~8 s (38.7 s to 46.9 s after power on) just when UGOS starts Docker (38 s). Docker then starts the containers that publish ports on `192.168.1.210` **with no network at all**; a restart does not repair them, only a recreation does.
This service runs for 10 minutes after boot: once the LAN IP is up and the gateway answers, it removes the compose containers that have no network and restarts doco-cd, which recreates every stack from git (checked: doco-cd redeploys missing containers when it starts).
Only the stacks listed in `heal.sh` are touched, never UGOS containers.

| File | Content |
|---|---|
| `heal.sh` | the check and repair loop (`--dry-run` = one check, changes nothing) |
| `docker-net-heal.service` | systemd unit, started after Docker |

Install (by hand, UGOS may drop `/etc/systemd/system` on an update: redo it then):

    sudo install -d /volume2/stacks/docker-net-heal
    sudo install -m 755 heal.sh /volume2/stacks/docker-net-heal/heal.sh
    sudo install -m 644 docker-net-heal.service /etc/systemd/system/
    sudo systemctl daemon-reload && sudo systemctl enable --now docker-net-heal.service

Manual repair: `sudo bash /volume2/stacks/docker-net-heal/heal.sh`. Logs: `journalctl -t docker-net-heal`.
