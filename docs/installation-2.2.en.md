# Install VCore Pulse 2.2

1. Open [Downloads](https://www.voigtcore.com.br/downloads/2.2.0/).
2. Match OS and processor: Windows x64; Linux x64/ARM64; macOS Intel/Apple Silicon.
3. Verify `SHA256SUMS.txt`. Hashes check integrity; they are not publisher signatures.
4. Back up before updating. Preserve the database, identity and keys. Use disposable data for validation.

## Windows

Open `VCorePulse-2.2.0-windows10-11-x64-Setup.exe` as the Pulse user. This is build 20, with an automatically verified legacy upgrade. Authenticode signing is not available. If blocked by policy, ask the administrator for review; do not disable OS protections.

## Linux and macOS

Runtime and native SQLCipher are included. No npm installation is required. Do not use sudo.

```sh
# In Downloads, replace this filename with your platform's file.
sh VCorePulse-2.2.0-linux-x64.sh
```

Linux desktop requires unlocked Secret Service and `secret-tool`. The installer enables a user systemd service when available; otherwise start `~/.local/opt/vcore-pulse/start-vcore-pulse.sh` manually.

Headless Linux can explicitly choose:

```sh
sh VCorePulse-2.2.0-linux-arm64.sh --headless-key-files
```

The SQLCipher database stays encrypted. Separate keys are stored in `~/.config/vcore-pulse/keys` with mode 0600. **This is permission protection, not an encrypted OS vault.** Anyone obtaining both keys and database can access data. Protect the host and preserve keys with the backup procedure; never publish them.

macOS uses Keychain and a user LaunchAgent. Apple notarization is not available. Do not disable Gatekeeper. If blocked, wait for signed distribution or support instructions. Manual start:

```sh
"$HOME/Library/Application Support/VCore Pulse/start-vcore-pulse.sh"
```

Use `--no-start` to install without enabling services. A loaded macOS service restarts the process automatically. Stop services before maintenance:

```sh
# Linux
systemctl --user stop vcore-pulse.service
# macOS
launchctl bootout "gui/$(id -u)/com.voigtcore.pulse"
```

Open `http://127.0.0.1:4173` after starting. Keep the dashboard on loopback; use an authorized SSH tunnel for a remote server.

## VM acceptance checklist

Use a disposable VM with matching native architecture, at least 4 GB RAM and sufficient disk space. Verify installation, version, all five languages, CPU/memory/disk collection, charts and PDF export. Stop/restart and check identity/history; reinstall preserving data. Check OS key storage, user service, login/reboot, permissions and backup restoration.

Do not enter card details or create payments just to test an installer. The owner already confirmed Windows Pix and a real international card purchase; Linux/macOS still require functional acceptance in your environment.

Automated installer/dashboard/PDF/restart/tamper tests use disposable external keys. They **do not establish** Keychain/Secret Service interaction, full service lifecycle, all hardware sensors or database rollback across versions.

[Platform matrix](platforms-2.2.md) · [Visual guide](https://www.voigtcore.com.br/manual/pulse/en/) · suporte@voigtcore.com.br

## A purchase attempt is pending?

Open the license screen: Pulse retrieves the existing attempt without creating another charge. For an unpaid card checkout, select **Close unpaid attempt**. The bank must confirm closure before another purchase is enabled. Do not clear browser storage to bypass verification. An active license is independent of confirmation of a new purchase.

## História em camadas / Layered history

Build 20 includes rotation and large-query fixes. Update without uninstalling, as the same user. SAFE keeps originals and does not reclaim disk space automatically. Encrypted databases may not shrink when compressed. See the platform matrix for validation and limits.
