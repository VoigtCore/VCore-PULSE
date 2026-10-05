#!/bin/bash
set -euo pipefail
umask 077
RESOURCES="$(cd -- "$(dirname -- "$0")" && pwd -P)"
APP="$HOME/Library/Application Support/VCore Pulse"
DATA="$HOME/Library/Application Support/VCore Pulse Data"
LAUNCHER="/Applications/VCore Pulse.app"
LABEL="gui/$(id -u)/com.voigtcore.pulse"
EXPECTED="$(cat "$RESOURCES/payload.sha256")"
ACTUAL="$(/usr/bin/shasum -a 256 "$RESOURCES/installer.sh" | /usr/bin/awk '{print $1}')"
[[ "$(uname -m)" == "$(cat "$RESOURCES/architecture")" ]] || { echo 'MAC_ARCHITECTURE_MISMATCH'; exit 2; }
[[ "$EXPECTED" == "$ACTUAL" ]] || { echo 'INSTALLER_INTEGRITY_FAILED'; exit 3; }
[[ ! -L "$APP" && ! -L "$DATA" && ! -L /Applications && ! -L "$LAUNCHER" ]] || { echo 'SYMLINK_DESTINATION_REFUSED'; exit 4; }
if [[ -e "$LAUNCHER" ]]; then
  [[ "$(/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' "$LAUNCHER/Contents/Info.plist")" == com.voigtcore.pulse.launcher ]] || { echo 'APPLICATION_DESTINATION_OCCUPIED'; exit 5; }
fi
SOURCE_BUNDLE="$(cd "$RESOURCES/../.." && pwd -P)"
if [[ "$SOURCE_BUNDLE" != "$LAUNCHER" ]]; then
  if [[ -w /Applications && ( ! -e "$LAUNCHER" || -w "$LAUNCHER" ) ]]; then
    /bin/bash "$RESOURCES/install-application.sh" "$SOURCE_BUNDLE"
  else
    /usr/bin/osascript - "$RESOURCES/install-application.sh" "$SOURCE_BUNDLE" <<'APPLESCRIPT'
on run arguments
  set helperPath to item 1 of arguments
  set sourcePath to item 2 of arguments
  do shell script "/bin/bash " & quoted form of helperPath & " " & quoted form of sourcePath with administrator privileges
end run
APPLESCRIPT
  fi
  # Keep the user's previous launcher recoverable, outside Applications.
  LEGACY="$HOME/Applications/VCore Pulse.app"
  if [[ -d "$LEGACY" && ! -L "$LEGACY" ]] && [[ "$(/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' "$LEGACY/Contents/Info.plist")" == com.voigtcore.pulse.launcher ]]; then
    BACKUPS="$HOME/Library/Application Support/VCore Pulse Launcher Backups"
    [[ ! -L "$BACKUPS" ]] || exit 4
    mkdir -p "$BACKUPS"
    mv "$LEGACY" "$BACKUPS/VCore Pulse-$(uuidgen).app"
  fi
fi
echo 'Verifying Pulse package…'
if [[ ! -f "$APP/.dmg-payload.sha256" ]] || [[ "$(cat "$APP/.dmg-payload.sha256")" != "$EXPECTED" ]]; then
  # Reuse the released installer and its identity/schema/rollback safeguards.
  /bin/sh "$RESOURCES/installer.sh" --no-start
  printf '%s\n' "$EXPECTED" > "$APP/.dmg-payload.sha256"
fi
"$APP/runtime/bin/node" "$APP/verify-package.cjs" "$APP"
echo 'Starting Pulse…'
mkdir -p "$HOME/Library/LaunchAgents"
"$APP/runtime/bin/node" "$APP/install-service.cjs" "$APP" "$DATA"
if ! /bin/launchctl print "$LABEL" >/dev/null 2>&1; then
  /bin/launchctl bootstrap "gui/$(id -u)" "$HOME/Library/LaunchAgents/com.voigtcore.pulse.plist"
fi
/bin/launchctl kickstart "$LABEL"
ready=0
for ((i=0;i<120;i++)); do
  if /usr/bin/curl --fail --silent --max-time 2 http://127.0.0.1:4173/api/pulse/health > "$DATA/.launcher-health.json"; then
    if "$APP/runtime/bin/node" -e 'const fs=require("fs");const h=JSON.parse(fs.readFileSync(process.argv[1]));process.exit(h.status==="ok"&&h.version==="2.2.0"?0:1)' "$DATA/.launcher-health.json"; then ready=1; break; fi
  fi
  sleep 1
done
[[ "$ready" == 1 ]] || { echo 'PULSE_START_TIMEOUT: inspect Pulse logs in Library/Application Support/VCore Pulse Data'; exit 6; }
echo 'Pulse ready. Opening dashboard…'
/usr/bin/open http://127.0.0.1:4173
