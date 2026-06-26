#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

source "$ROOT_DIR/lib/log.sh"

apt_install() {
  sudo apt install -y "$@"
}

install_glab() {
  info "Installing GitLab CLI..."

  if [[ ! -f /etc/os-release ]]; then
    warn "Cannot detect OS version: skip glab auto-install."
    return
  fi

  . /etc/os-release

  if [[ "${ID:-}" != "ubuntu" ]]; then
    warn "Non-Ubuntu distro detected: skip glab auto-install."
    return
  fi

  if dpkg --compare-versions "${VERSION_ID:-0}" ge "24.04"; then
    info "Ubuntu $VERSION_ID detected: installing glab via apt..."
    apt_install glab
  else
    info "Ubuntu $VERSION_ID detected: installing glab via snap..."
    apt_install snapd
    sudo snap install glab
  fi
}

basic_packages=(
  git
  gh
  curl
  wget
  unzip
  zip
  tar
  ca-certificates
  gpg
  fontconfig
  stow
  zsh
)

dev_packages=(
  build-essential
  cmake
  ninja-build
  pkg-config
  ccache
  gdb
  valgrind
  clang
  clangd
  clang-format
  clang-tidy
  lldb
  cppcheck
  libxcb-cursor0
  libxcb-cursor-dev
  libgl1-mesa-dev
  libglu1-mesa-dev
  mesa-common-dev
  python3-full
  python3-pip
  python3-dev
)

useful_packages=(
  ripgrep
  fd-find
  fzf
  tree
  htop
  neovim
  neofetch
  ibus-unikey
  qpdfview
  cloud-guest-utils
  gparted
)

info "Updating apt..."
sudo apt update
success "Apt package index updated."

info "Installing basic tools..."
apt_install "${basic_packages[@]}"
install_glab
success "Basic tools installed."


info "Installing development environment..."
apt_install "${dev_packages[@]}"
pip3 install cmake-format
success "Development environment packages installed."

info "Installing useful tools..."
apt_install "${useful_packages[@]}"
success "Useful tools installed."
