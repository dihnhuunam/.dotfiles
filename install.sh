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

info "Installing Ubuntu packages..."
./packages/ubuntu.sh

info "Installing Fonts..."
./packages/font.sh

info "Installing WezTerm..."
./packages/wezterm.sh

info "Setting up Zsh..."
./packages/zsh.sh

info "Creating symlinks..."
stow zsh
stow wezterm

success "Done. Please logout and login again."
