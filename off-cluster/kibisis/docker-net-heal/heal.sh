#!/bin/bash
set -u
LAN_IP=192.168.1.210
GATEWAY=192.168.1.1
PROJECTS=" postgres postgres-public postgres-gitlab garage victoriametrics victorialogs cadvisor node-exporter speedtest doco-cd "
DOCO_CD=/volume2/stacks/doco-cd/compose.yaml
ROUNDS=${ROUNDS:-40}
DRY_RUN=0
[ "${1:-}" = "--dry-run" ] && { DRY_RUN=1; ROUNDS=1; }

log() { logger -t docker-net-heal "$*"; echo "$*"; }

broken() {
  local c p
  for c in $(docker ps -q); do
    [ "$(docker inspect -f '{{len .NetworkSettings.Networks}}' "$c")" = 0 ] || continue
    p=$(docker inspect -f '{{index .Config.Labels "com.docker.compose.project"}}' "$c")
    case "$PROJECTS" in *" $p "*) docker inspect -f '{{.Name}}' "$c" | tr -d / ;; esac
  done
}

for _ in $(seq 1 "$ROUNDS"); do
  if docker info >/dev/null 2>&1 \
    && ip -4 -o addr | grep -q " $LAN_IP/" \
    && ping -c1 -W1 "$GATEWAY" >/dev/null 2>&1; then
    list=$(broken)
    if [ -n "$list" ]; then
      log "containers without network: $(echo $list)"
      if [ "$DRY_RUN" = 0 ]; then
        docker rm -f $list >/dev/null
        docker compose -f "$DOCO_CD" up -d --force-recreate >/dev/null 2>&1
        log "removed them and restarted doco-cd, which recreates every stack from git"
        sleep 60
      fi
    fi
  fi
  [ "$DRY_RUN" = 1 ] || sleep 15
done
