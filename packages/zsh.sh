#!/usr/bin/env bash

set -e

echo "Installing Oh My Zsh..."

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh already installed. Skipping."
fi

echo "Installing Powerlevel10k..."

P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

if [ ! -d "$P10K_DIR" ]; then
  mkdir -p "$(dirname "$P10K_DIR")"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
else
  echo "Powerlevel10k already installed. Skipping."
fi

echo "Changing default shell to zsh..."

if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s "$(which zsh)"
else
  echo "Default shell is already zsh. Skipping."
fi

echo "Done setting up Zsh."
