#!/usr/bin/env bash

set -e

FONT_NAME="JetBrainsMono"
FONT_ZIP="${FONT_NAME}.zip"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_ZIP}"
FONT_DIR="$HOME/.local/share/fonts/${FONT_NAME}NerdFont"
TMP_DIR="$(mktemp -d)"

echo "Installing JetBrainsMono Nerd Font..."

if fc-match "JetBrainsMono Nerd Font" >/dev/null 2>&1; then
  echo "JetBrainsMono Nerd Font may already be installed."
fi

mkdir -p "$FONT_DIR"

echo "Downloading ${FONT_ZIP}..."
curl -fLo "$TMP_DIR/$FONT_ZIP" "$FONT_URL"

echo "Extracting font files..."
unzip -o "$TMP_DIR/$FONT_ZIP" -d "$FONT_DIR"

echo "Refreshing font cache..."
fc-cache -fv "$HOME/.local/share/fonts" >/dev/null

echo "Cleaning up..."
rm -rf "$TMP_DIR"

echo "Done installing JetBrainsMono Nerd Font."
