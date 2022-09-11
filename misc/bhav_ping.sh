#!/usr/bin/env bash
set -euxo pipefail
MAX_WORKERS=${1:-10}
DURATION=${2:-300}

COUNTER=0
while [[ $COUNTER -le $MAX_WORKERS ]]
do
    nohup watch -n 0.1 curl -k "https://bhav.ingress.local/my-lucky-number/daniel" >> output.txt 2>&1 &
    COUNTER="$((COUNTER+1))"
done

sleep "$DURATION"
pgrep watch | xargs kill
