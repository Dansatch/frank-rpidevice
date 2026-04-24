# frank-rpidevice

Raspberry Pi device client for Frank.

## Install

## 🔐 SSH Setup (for private repo)

```bash
ssh-keygen -t ed25519 -C "frank-pi"
cat ~/.ssh/id_ed25519.pub
```

Add the key to GitHub -> Settings -> SSH keys(Authentication)

Then on raspbery pi run:

```bash
git clone git@github.com:Dansatch/frank-rpidevice.git
cd frank-rpidevice
./install.sh
```
