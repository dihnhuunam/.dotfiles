#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

source "$ROOT_DIR/lib/log.sh"

info "Installing WezTerm..."

if command -v wezterm >/dev/null 2>&1; then
  warn "WezTerm already installed. Skipping."
  exit 0
fi

info "Adding WezTerm apt repository..."

curl -fsSL https://apt.fury.io/wez/gpg.key \
  | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg

echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' \
  | sudo tee /etc/apt/sources.list.d/wezterm.list >/dev/null

sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg

info "Updating apt..."
sudo apt update

info "Installing wezterm package..."
sudo apt install -y wezterm

success "Done installing WezTerm."
