#!/usr/bin/env bash
set -e

APP_DIR="/opt/frank-rpidevice"
SERVICE_FILE="frank-rpidevice.service"

echo "Creating app directory..."
sudo mkdir -p "$APP_DIR"
sudo chown -R "$USER":"$USER" "$APP_DIR"

echo "Copying files..."
cp client.js package.json start.sh setup-audio.sh "$APP_DIR"/
cp config.template.json "$APP_DIR"/

if [ -f package-lock.json ]; then
  cp package-lock.json "$APP_DIR"/
fi

if [ ! -f "$APP_DIR/config.json" ]; then
  cp config.template.json "$APP_DIR/config.json"
fi

echo "Installing OS dependencies..."
sudo apt update
sudo apt install -y mpg123 alsa-utils sox curl

echo "Installing Node.js (if missing)..."
if ! command -v node >/dev/null 2>&1; then
  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
  sudo apt install -y nodejs
fi

echo "Node version:"
node -v || true

echo "Installing Node dependencies..."
cd "$APP_DIR"
npm install

echo "Running audio setup..."
bash "$APP_DIR/setup-audio.sh"

echo "Installing systemd service..."
sudo cp "$OLDPWD/$SERVICE_FILE" /etc/systemd/system/frank-rpidevice.service
sudo systemctl daemon-reload
sudo systemctl enable frank-rpidevice

echo "Done."
echo "Edit $APP_DIR/config.json if needed, then run:"
echo "sudo systemctl start frank-rpidevice"