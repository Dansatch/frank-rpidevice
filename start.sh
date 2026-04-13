#!/usr/bin/env bash
set -e

cd /opt/frank-rpidevice

CONFIG_FILE="/opt/frank-rpidevice/config.json"

if [ -f "$CONFIG_FILE" ]; then
  VOLUME=$(python3 -c "import json; print(json.load(open('$CONFIG_FILE')).get('volumePercent', 80))")
else
  VOLUME=80
fi

amixer sset Master "${VOLUME}%" || true

node client.js