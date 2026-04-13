#!/usr/bin/env bash
set -e

APP_DIR="/opt/frank-rpidevice"
BEEP_START="$APP_DIR/beep_start.wav"
BEEP_STOP="$APP_DIR/beep_stop.wav"

echo "Setting up audio..."

if ! command -v sox >/dev/null 2>&1; then
  echo "Installing sox..."
  sudo apt update
  sudo apt install -y sox
fi

if [ ! -f "$BEEP_START" ]; then
  echo "Creating start beep..."
  sox -n -r 16000 -c 1 "$BEEP_START" synth 0.12 sine 1000
fi

if [ ! -f "$BEEP_STOP" ]; then
  echo "Creating stop beep..."
  sox -n -r 16000 -c 1 "$BEEP_STOP" synth 0.12 sine 600
fi

echo "Audio setup complete."