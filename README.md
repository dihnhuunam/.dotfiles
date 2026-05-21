# Dotfiles

Personal dotfiles for setting up a basic Ubuntu development environment.

## Repository Structure

```text
.
├── README.md
├── install.sh
├── packages
│   ├── ubuntu.sh
│   ├── wezterm.sh
│   └── zsh.sh
├── wezterm
│   └── .config
│       └── wezterm
│           └── wezterm.lua
└── zsh
    └── .zshrc
```

## Scripts

- `install.sh`: main setup script
- `packages/ubuntu.sh`: installs Ubuntu packages
- `packages/wezterm.sh`: installs WezTerm
- `packages/zsh.sh`: installs Oh My Zsh and Powerlevel10k

## Usage

Clone the repository:

```bash
git clone https://github.com/dihnhuunam/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

Make all scripts executable:

```bash
chmod +x install.sh packages/*.sh
```

Run the installer:

```bash
./install.sh
```

After installation, log out and log back in to apply the default shell change to Zsh.

## Manual Stow

To manually create symlinks:

```bash
stow zsh
stow wezterm
```

To remove symlinks:

```bash
stow -D zsh
stow -D wezterm
```
