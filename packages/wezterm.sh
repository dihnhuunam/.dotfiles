#!/usr/bin/env bash

set -e

echo "Installing WezTerm..."

if command -v wezterm >/dev/null 2>&1; then
  echo "WezTerm already installed. Skipping."
  exit 0
fi

echo "Adding WezTerm apt repository..."

curl -fsSL https://apt.fury.io/wez/gpg.key \
  | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg

echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' \
  | sudo tee /etc/apt/sources.list.d/wezterm.list >/dev/null

sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg

echo "Updating apt..."
sudo apt update

echo "Installing wezterm package..."
sudo apt install -y wezterm

echo "Done installing WezTerm."
