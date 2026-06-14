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

echo "Installing development tools..."
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
  python3-full \
  python3-pip \
  python3-dev

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
  qpdfview

echo "Done installing Ubuntu packages."
