# Speed test

Internet speed from the NAS (2.5 Gbit/s port), pushed to VictoriaMetrics.

| File | Content |
|---|---|
| `compose.yaml` | Alpine container as nobody, read-only: a loop runs the test every 6 h (00:47, 06:47, 12:47, 18:47 UTC) |
| `speedtest.sh` | Ookla speed test, 3 attempts, push of the results |
