#!/bin/sh
# Speed test from the NAS (2.5 Gbit/s port), pushed to VictoriaMetrics.
set -eu
cd /tmp
[ -x ./speedtest ] || { wget -qO cli.tgz https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-linux-x86_64.tgz && tar xzf cli.tgz speedtest; }
for try in 1 2 3; do
  if ./speedtest --accept-license --accept-gdpr --server-id=62493 -f tsv --output-header 2>/dev/null | tail -2 > out.tsv && [ "$(wc -l < out.tsv)" -eq 2 ]; then break; fi
  echo "attempt $try failed"; [ "$try" -lt 3 ] && sleep 30
done
[ "$(wc -l < out.tsv)" -eq 2 ]
awk -F'\t' -v now="$(date +%s)" '
  NR == 1 { for (i = 1; i <= NF; i++) h[$i] = i; next }
  { s = $h["server name"]; gsub(/"/, "", s); l = "source=\"nas\",server=\"" s "\""
    printf "speedtest_download_bits_per_second{%s} %.0f\n", l, $h["download"] * 8
    printf "speedtest_upload_bits_per_second{%s} %.0f\n", l, $h["upload"] * 8
    printf "speedtest_ping_ms{%s} %s\n", l, $h["idle latency"]
    printf "speedtest_jitter_ms{%s} %s\n", l, $h["idle jitter"]
    printf "speedtest_last_run_timestamp_seconds{%s} %s\n", l, now }' out.tsv > metrics.txt
cat metrics.txt
wget -qO- --header "Authorization: Basic $(printf '%s:%s' "$VM_USER" "$VM_PASSWORD" | base64 | tr -d '\n')" \
  --post-file metrics.txt http://192.168.1.51:8428/api/v1/import/prometheus
echo "$(date -Iseconds) pushed"
