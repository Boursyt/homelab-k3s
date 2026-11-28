# smartctl-exporter

SMART health of the NAS disks (HDD and NVMe), port 9633, scraped by `k3s/metrics/vmstaticscrape-smartctl-nas.yaml`. Privileged on purpose: smartctl needs the raw devices.

| File | Content |
|---|---|
| `compose.yaml` | smartctl-exporter |
