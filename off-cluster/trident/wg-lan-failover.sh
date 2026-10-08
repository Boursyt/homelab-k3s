#!/bin/bash
# Give 192.168.1.0/24 to whichever LAN gateway answers (aegis, else keraunos). Run every 10 s by the timer.
set -u
LAN=192.168.1.0/24
AEGIS_KEY='E/UjJqdJHUbWmxvBSsRt8spis48lxgFlJEBwmYy+ND0='     AEGIS_IP=10.8.0.2
KERAUNOS_KEY='V6BrzqcgICGyv7yE7UyLQuw9a0eYoputBIMzs8bE5BE='  KERAUNOS_IP=10.8.0.10

alive() { ping -c 2 -i 0.3 -W 2 "$1" >/dev/null 2>&1; }

if alive "$AEGIS_IP"; then
    want=aegis
elif alive "$KERAUNOS_IP"; then
    want=keraunos
else
    exit 0
fi

current=$(wg show wg0 allowed-ips | awk -v lan="$LAN" '$0 ~ lan { print $1 }')
[ "$want" = aegis ] && want_key=$AEGIS_KEY || want_key=$KERAUNOS_KEY
[ "$current" = "$want_key" ] && exit 0

if [ "$want" = aegis ]; then
    wg set wg0 peer "$KERAUNOS_KEY" allowed-ips "$KERAUNOS_IP/32"
    wg set wg0 peer "$AEGIS_KEY" allowed-ips "$AEGIS_IP/32,$LAN"
else
    wg set wg0 peer "$AEGIS_KEY" allowed-ips "$AEGIS_IP/32"
    wg set wg0 peer "$KERAUNOS_KEY" allowed-ips "$KERAUNOS_IP/32,$LAN"
fi
ip route replace "$LAN" dev wg0
logger -t wg-lan-failover "home LAN $LAN now routed via $want"
