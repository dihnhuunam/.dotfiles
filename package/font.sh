#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

source "$ROOT_DIR/lib/log.sh"

FONT_NAME="JetBrainsMono"
FONT_ZIP="${FONT_NAME}.zip"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_ZIP}"
FONT_DIR="$HOME/.local/share/fonts/${FONT_NAME}NerdFont"
TMP_DIR="$(mktemp -d)"

info "Installing JetBrainsMono Nerd Font..."

if fc-match "JetBrainsMono Nerd Font" >/dev/null 2>&1; then
  warn "JetBrainsMono Nerd Font may already be installed."
fi

mkdir -p "$FONT_DIR"

info "Downloading ${FONT_ZIP}..."
curl -fLo "$TMP_DIR/$FONT_ZIP" "$FONT_URL"

info "Extracting font files..."
unzip -o "$TMP_DIR/$FONT_ZIP" -d "$FONT_DIR"

info "Refreshing font cache..."
fc-cache -fv "$HOME/.local/share/fonts" >/dev/null

info "Cleaning up..."
rm -rf "$TMP_DIR"

success "Done installing JetBrainsMono Nerd Font."
