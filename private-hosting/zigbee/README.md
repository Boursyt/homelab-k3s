# Zigbee

Zigbee devices through a USB dongle plugged into aegis (zigbee.lab).

| File | Content |
|---|---|
| `namespace.yaml` | `zigbee` namespace |
| `configmap-mosquitto.yaml` | Mosquitto config (authentication required) |
| `deployment-mosquitto.yaml` | MQTT broker; passwords hashed at start from a Secret |
| `service-mosquitto.yaml` | Service |
| `pvc-zigbee2mqtt-data.yaml` | Zigbee2MQTT data: network key, devices, coordinator backup |
| `configmap-zigbee2mqtt-seed.yaml` | initial config, written only on first start |
| `deployment-zigbee2mqtt.yaml` | Zigbee2MQTT as uid 1000 (group dialout), read-only; gets the dongle from the device plugin (`homelab/zigbee`, see `k3s/devices`), hence runs on aegis |
| `service-zigbee2mqtt.yaml` | Service |
| `ingress-zigbee2mqtt.yaml` | `zigbee.lab.theoboursy.fr` |
