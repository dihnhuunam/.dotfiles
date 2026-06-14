#!/usr/bin/env bash

set -e

echo "Installing Oh My Zsh..."

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh already installed. Skipping."
fi

echo "Installing Zsh plugins..."

ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

ZSH_SYNTAX_HIGHLIGHTING_DIR="$ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting"
ZSH_AUTOSUGGESTIONS_DIR="$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions"

if [ ! -d "$ZSH_SYNTAX_HIGHLIGHTING_DIR" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_SYNTAX_HIGHLIGHTING_DIR"
else
  echo "zsh-syntax-highlighting already installed. Skipping."
fi

if [ ! -d "$ZSH_AUTOSUGGESTIONS_DIR" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_AUTOSUGGESTIONS_DIR"
else
  echo "zsh-autosuggestions already installed. Skipping."
fi

echo "Changing default shell to zsh..."

if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s "$(which zsh)"
else
  echo "Default shell is already zsh. Skipping."
fi

echo "Done setting up Zsh."
