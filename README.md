# frank-rpidevice

Raspberry Pi device client for Frank.

## Features

- Wake word detection (Porcupine)
- Voice activity detection (Cobra)
- Audio capture and playback
- Automatic startup via systemd
- Remote updates via Git
- Configurable through `config.json`

---

## Prerequisites

- Raspberry Pi OS
- Internet connection
- Git
- SSH access
- Picovoice Access Key
- Frank server running and reachable

---

## 🔐 SSH Setup (Private Repository Access)

Generate an SSH key:

```bash
ssh-keygen -t ed25519 -C "frank-pi"
```

Display the public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

Add the key to:

GitHub → Settings → SSH and GPG Keys → New SSH Key

Use Authentication access.

Verify GitHub connectivity:

```bash
ssh -T git@github.com
```

---

## Installation

Clone and install:

```bash
git clone git@github.com:Dansatch/frank-rpidevice.git
cd frank-rpidevice
./install.sh
```

---

## Configuration

Edit the device configuration:

```bash
nano /opt/frank-rpidevice/config.json
```

Example:

```json
{
  "serverUrl": "wss://your-server/v1/device/stream",
  "deviceId": "frank-rpi-01",
  "speakerDevice": "plughw:1,0",
  "micDeviceIndex": 1,
  "porcupineSensitivity": 0.75,
  "volume": 100
}
```

Save:

```text
Ctrl + O
Enter
Ctrl + X
```

---

## Service Management

Start Frank:

```bash
sudo systemctl start frank-rpidevice
```

Stop Frank:

```bash
sudo systemctl stop frank-rpidevice
```

Restart Frank:

```bash
sudo systemctl restart frank-rpidevice
```

Check service status:

```bash
sudo systemctl status frank-rpidevice
```

Enable startup on boot:

```bash
sudo systemctl enable frank-rpidevice
```

---

## Logs & Troubleshooting

View live logs:

```bash
journalctl -u frank-rpidevice -f
```

View last 100 log lines:

```bash
journalctl -u frank-rpidevice -n 100
```

View logs from current boot:

```bash
journalctl -u frank-rpidevice -b
```

View logs since today:

```bash
journalctl -u frank-rpidevice --since today
```

---

## Updating

Pull latest changes:

```bash
cd ~/frank-rpidevice
git pull
```

Reinstall updated files:

```bash
./install.sh
```

Restart Frank:

```bash
sudo systemctl restart frank-rpidevice
```

---

## Audio Diagnostics

List recording devices:

```bash
arecord -l
```

List playback devices:

```bash
aplay -l
```

List devices detected by PvRecorder:

```bash
node -e "const { PvRecorder } = require('@picovoice/pvrecorder-node'); console.log(PvRecorder.getAvailableDevices())"
```

Test microphone:

```bash
arecord -D plughw:1,0 -f S16_LE -r 16000 -c 1 -d 3 /tmp/test.wav
aplay -D plughw:1,0 /tmp/test.wav
```

---

## Wake Word Tuning

Edit:

```bash
nano /opt/frank-rpidevice/config.json
```

Adjust:

```json
"porcupineSensitivity": 0.75
```

Suggested values:

```text
0.65 Conservative
0.75 Balanced
0.85 Aggressive
```

After changes:

```bash
sudo systemctl restart frank-rpidevice
```

---

## Repository Layout

```text
frank-rpidevice/
├── client.js
├── config.template.json
├── install.sh
├── start.sh
├── package.json
└── README.md
```
