#!/usr/bin/env bash

set -e

echo "Installing Ubuntu packages..."
./packages/ubuntu.sh

echo "Installing WezTerm..."
./packages/wezterm.sh

echo "Setting up Zsh..."
./packages/zsh.sh

echo "Creating symlinks..."
stow zsh
stow wezterm

echo "Done. Please restart terminal."
