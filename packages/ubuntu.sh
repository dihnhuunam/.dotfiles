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
  stow \
  fontconfig \
  zsh

echo "Installing C/C++ development tools..."
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
  cppcheck

echo "Installing useful CLI tools..."
sudo apt install -y \
  ripgrep \
  fd-find \
  fzf \
  tree \
  htop \
  neovim \
  neofetch

echo "Done installing Ubuntu packages."
