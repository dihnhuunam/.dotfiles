#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

source "$ROOT_DIR/lib/log.sh"

info "Updating apt..."
sudo apt update

info "Installing basic tools..."
sudo apt install -y \
  git \
  gh \
  curl \
  wget \
  unzip \
  zip \
  tar \
  ca-certificates \
  gpg \
  fontconfig \
  stow \
  zsh

info "Installing GitLab CLI..."

if [ -f /etc/os-release ]; then
  . /etc/os-release

  if [ "$ID" = "ubuntu" ]; then
    if dpkg --compare-versions "$VERSION_ID" ge "24.04"; then
      info "Ubuntu $VERSION_ID detected: installing glab via apt..."
      sudo apt install -y glab
    else
      info "Ubuntu $VERSION_ID detected: installing glab via snap..."
      sudo apt install -y snapd
      sudo snap install glab
    fi
  else
    warn "Non-Ubuntu distro detected: skip glab auto-install."
  fi
else
  warn "Cannot detect OS version: skip glab auto-install."
fi

success "Done installing Ubuntu packages."

info "Installing development environment..."
sudo apt install -y \
  build-essential \
  cmake \
  ninja-build \
  pkg-config \
  ccache \
  gdb \
  valgrind \
  clang \
  clangd \
  clang-format \
  clang-tidy \
  lldb \
  cppcheck \
  libxcb-cursor0 \
  libxcb-cursor-dev \
  libgl1-mesa-dev \
  libglu1-mesa-dev \
  mesa-common-dev \
  python3-full \
  python3-pip \
  python3-dev

pip3 install clang-format

info "Installing useful tools..."
sudo apt install -y \
  ripgrep \
  fd-find \
  fzf \
  tree \
  htop \
  neovim \
  neofetch \
  ibus-unikey \
  qpdfview \
  cloud-guest-utils\
  gparted
