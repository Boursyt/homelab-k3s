# Metrics and logs

Collection of every metric into VictoriaMetrics and every pod log into VictoriaLogs, both on the NAS (no Prometheus, no Loki).

| File | Content |
|---|---|
| `namespace.yaml` | `monitoring` namespace |
| `helmrelease-vm-operator.yaml` | VictoriaMetrics operator: runs vmagent / vmalert, reads ServiceMonitors |
| `helmrelease-kps.yaml` | kube-prometheus-stack without Prometheus: CRDs, kube-state-metrics (+ Flux objects as `gotk_resource_info`), rules |
| `vmpodscrape-flux.yaml` | Flux controllers metrics |
| `service-victoriametrics.yaml` | in-cluster name of VictoriaMetrics |
| `endpointslice-victoriametrics-nas.yaml` | points that Service to the NAS |
| `helmrelease-victoria-logs-collector.yaml` | vlagent DaemonSet: reads `/var/log/pods` on every node, sends to VictoriaLogs |
| `service-victorialogs.yaml`, `endpointslice-victorialogs-nas.yaml` | in-cluster name of VictoriaLogs, pointing to the NAS |
| `vmagent-vmagent.yaml` | scraper, writes to VictoriaMetrics |
| `secret-vmagent-scrape-token.yaml` | token used to scrape the Kubernetes components |
| `vmalert-vmalert.yaml` | evaluates the recording rules the Kubernetes dashboards need; its alerts are discarded (alerting = Gatus → ntfy) |
| `vmstaticscrape-*.yaml` | targets outside Kubernetes: node-exporters, NAS Postgres, PgBouncer, cAdvisor, Home Assistant |
| `cronjob-speedtest.yaml` | internet speed from a node every 6 h |
| `*-vmauth-public.yaml` | read-only VictoriaMetrics proxy for the public Glance: query endpoints only, reachable only from `glance-public` |
| `vmstaticscrape-gatus.yaml`, `vmstaticscrape-gatus-public.yaml` | check results of the private and public Gatus (jobs `gatus`, `gatus-public`) |
| `secret-victoriametrics-auth.sops.yaml`, `secret-victorialogs-auth.sops.yaml`, `secret-vmauth-public.sops.yaml` | Secrets encrypted with SOPS (see the root README) |
