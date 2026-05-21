#!/usr/bin/env bash

set -e

# Colors
GREEN="\033[0;32m"
BLUE="\033[0;34m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
NC="\033[0m"

info() {
  echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
  echo -e "${GREEN}[OK]${NC} $1"
}

warn() {
  echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

backup_if_exists() {
  local target="$1"

  if [ -e "$target" ] && [ ! -L "$target" ]; then
    local backup="${target}.backup.$(date +%Y%m%d_%H%M%S)"
    warn "Existing $target found. Backing it up to $backup"
    mv "$target" "$backup"
  fi
}

info "Installing Ubuntu packages..."
./packages/ubuntu.sh

info "Installing Fonts..."
./packages/font.sh

info "Installing WezTerm..."
./packages/wezterm.sh

info "Setting WezTerm as default terminal..."

if command -v gsettings >/dev/null 2>&1 && command -v wezterm >/dev/null 2>&1; then
  gsettings set org.gnome.desktop.default-applications.terminal exec wezterm
  gsettings set org.gnome.desktop.default-applications.terminal exec-arg ''
  success "WezTerm is set as the default terminal."
else
  warn "Cannot set default terminal automatically. gsettings or wezterm not found."
fi

info "Setting up Zsh..."
./packages/zsh.sh

info "Backing up existing config files..."
backup_if_exists "$HOME/.zshrc"
backup_if_exists "$HOME/.config/wezterm"

info "Creating symlinks..."
stow zsh
stow wezterm

success "Done. Please restart the terminal."
