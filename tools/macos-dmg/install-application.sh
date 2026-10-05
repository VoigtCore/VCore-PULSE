#!/bin/bash
# This helper may be authorized by macOS only to copy the application bundle.
# Runtime installation, Keychain and LaunchAgent always run as the signed-in user.
set -euo pipefail
SOURCE="${1:?Missing application source}"
DEST='/Applications/VCore Pulse.app'
[[ -d "$SOURCE/Contents" && ! -L /Applications && ! -L "$DEST" ]] || exit 4
[[ "$(/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' "$SOURCE/Contents/Info.plist")" == com.voigtcore.pulse.launcher ]] || exit 5
/usr/bin/codesign --verify --deep --strict "$SOURCE"
if [[ -e "$DEST" ]]; then
  [[ "$(/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' "$DEST/Contents/Info.plist")" == com.voigtcore.pulse.launcher ]] || exit 5
fi
STAGE="/Applications/.VCore-Pulse-$(/usr/bin/uuidgen).app"
/usr/bin/ditto "$SOURCE" "$STAGE"
/usr/bin/codesign --verify --deep --strict "$STAGE"
if [[ -e "$DEST" ]]; then
  PREVIOUS="/Applications/.VCore-Pulse-previous-$(/usr/bin/uuidgen).app"
  /bin/mv "$DEST" "$PREVIOUS"
fi
if ! /bin/mv "$STAGE" "$DEST"; then
  if [[ -n "${PREVIOUS:-}" ]]; then /bin/mv "$PREVIOUS" "$DEST"; fi
  exit 7
fi
echo APPLICATION_INSTALLED
