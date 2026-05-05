#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="$SCRIPT_DIR/Brewfile"
CONFIG_DIR="$SCRIPT_DIR/config"
MACOS_DEFAULTS="$SCRIPT_DIR/macos-defaults.sh"
BREW_BIN=""

install_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    BREW_BIN="$(command -v brew)"
  elif [[ -x /opt/homebrew/bin/brew ]]; then
    BREW_BIN="/opt/homebrew/bin/brew"
  elif [[ -x /usr/local/bin/brew ]]; then
    BREW_BIN="/usr/local/bin/brew"
  else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [[ -x /opt/homebrew/bin/brew ]]; then
      BREW_BIN="/opt/homebrew/bin/brew"
    elif [[ -x /usr/local/bin/brew ]]; then
      BREW_BIN="/usr/local/bin/brew"
    fi
  fi

  if [[ -n "$BREW_BIN" && "$BREW_BIN" != "$(command -v brew 2>/dev/null || true)" ]]; then
    eval "$("$BREW_BIN" shellenv)"
  fi
}

sync_config() {
  mkdir -p "$HOME/.config"
  rsync -a "$CONFIG_DIR/" "$HOME/.config/"
}

main() {
  install_homebrew
  brew bundle install --file "$BREWFILE"
  sync_config
  chmod +x "$MACOS_DEFAULTS"
  "$MACOS_DEFAULTS"
}

main "$@"
