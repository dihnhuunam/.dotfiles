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

run_script() {
  local script_path="$1"

  if [[ -x "$script_path" ]]; then
    "$script_path"
  elif [[ -f "$script_path" ]]; then
    bash "$script_path"
  else
    error "Script not found: $script_path"
    exit 1
  fi
}

info "Installing Ubuntu packages..."
run_script "./packages/ubuntu.sh"

info "Setting qpdfview as default PDF viewer..."

if command -v qpdfview >/dev/null 2>&1; then
  xdg-mime default qpdfview.desktop application/pdf
  success "qpdfview is set as the default PDF viewer."
else
  warn "qpdfview not found. Skipping default PDF viewer setup."
fi

info "Restarting IBus..."

if command -v ibus >/dev/null 2>&1; then
  ibus restart || warn "IBus restart failed. You may need to log out and log in again."
else
  warn "IBus is not installed."
fi

info "Installing Fonts..."
run_script "./packages/font.sh"

info "Installing Zsh..."
run_script "./packages/zsh.sh"

info "Installing WezTerm..."
run_script "./packages/wezterm.sh"

info "Setting WezTerm as default terminal..."

if command -v gsettings >/dev/null 2>&1 && command -v wezterm >/dev/null 2>&1; then
  if gsettings writable org.gnome.desktop.default-applications.terminal exec >/dev/null 2>&1; then
    gsettings set org.gnome.desktop.default-applications.terminal exec wezterm
    gsettings set org.gnome.desktop.default-applications.terminal exec-arg ''
    success "WezTerm terminal preference was updated."
  else
    warn "GNOME terminal setting is not available on this desktop environment."
  fi
else
  warn "Cannot set default terminal automatically. gsettings or wezterm not found."
fi

info "Creating config files..."

mkdir -p "$HOME/.config"

if [[ -f "./zsh/.zshrc" ]]; then
  cp "./zsh/.zshrc" "$HOME/.zshrc"
  success "Zsh config copied."
else
  warn "Zsh config not found: ./zsh/.zshrc"
fi

if [[ -d "./wezterm/.config/wezterm" ]]; then
  cp -r "./wezterm/.config/wezterm" "$HOME/.config/"
  success "WezTerm config copied."
else
  warn "WezTerm config directory not found: ./wezterm/.config/wezterm"
fi

success "Done. Please restart the terminal."
