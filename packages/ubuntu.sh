#!/usr/bin/env bash

set -e

echo "Updating apt..."
sudo apt update

echo "Installing basic tools..."
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
  zsh

echo "Installing GitLab CLI..."

if [ -f /etc/os-release ]; then
  . /etc/os-release

  if [ "$ID" = "ubuntu" ]; then
    if dpkg --compare-versions "$VERSION_ID" ge "24.04"; then
      echo "Ubuntu $VERSION_ID detected: installing glab via apt..."
      sudo apt install -y glab
    else
      echo "Ubuntu $VERSION_ID detected: installing glab via snap..."
      sudo apt install -y snapd
      sudo snap install glab
    fi
  else
    echo "Non-Ubuntu distro detected: skip glab auto-install."
  fi
else
  echo "Cannot detect OS version: skip glab auto-install."
fi

echo "Done installing Ubuntu packages."

echo "Installing development environment..."
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

echo "Installing useful tools..."
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


