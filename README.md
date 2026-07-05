# Dotfiles

Personal dotfiles for setting up an Ubuntu development environment. This repository focuses on terminal tooling, Zsh, WezTerm, Nerd Fonts, and common packages for C/C++, Python, Qt, and OpenGL work.

## Support

- Ubuntu is the primary target, especially Ubuntu desktop environments with `apt`, `sudo`, `xdg-mime`, `ibus`, and `gsettings`.
- Other distributions may work partially, but `package/ubuntu.sh` is written specifically for Ubuntu.
- Installation requires internet access and may prompt for your `sudo` password.

## Repository Structure

```text
.
├── install.sh
├── lib
│   └── log.sh
├── package
│   ├── font.sh
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

## Quick Start

```bash
git clone https://github.com/dihnhuunam/.dotfiles.git ~/dotfiles
chmod +x *./package/*.sh
cd ~/dotfiles
./install.sh
```

After the script finishes, open a new terminal or log out and back in so the default shell and linked configuration are applied.

## What the Installer Does

`install.sh` runs these steps:

1. Installs Ubuntu packages from `package/ubuntu.sh`.
2. Sets `qpdfview` as the default PDF viewer when available.
3. Restarts IBus when `ibus` is installed.
4. Installs JetBrainsMono Nerd Font.
5. Installs Oh My Zsh, Zsh plugins, and changes the default shell to Zsh.
6. Installs WezTerm from the official WezTerm apt repository.
7. Attempts to set WezTerm as the default terminal on GNOME.
8. Uses GNU Stow to link the `zsh` and `wezterm` configuration packages into `$HOME`.

## Installed Packages

`package/ubuntu.sh` installs these package groups:

- Basics: `git`, `gh`, `curl`, `wget`, `unzip`, `zip`, `tar`, `ca-certificates`, `gpg`, `fontconfig`, `stow`, `zsh`.
- GitLab CLI: `glab`; Ubuntu 24.04 and newer use `apt`, older Ubuntu versions use `snap`.
- C/C++: `build-essential`, `cmake`, `ninja-build`, `pkg-config`, `ccache`, `gdb`, `valgrind`, `clang`, `clangd`, `clang-format`, `clang-tidy`, `lldb`, `cppcheck`.
- Python: `python3`, `python3-full`, `python3-pip`, `python3-dev`, `python3-venv`, plus `cmake-format` through `pip --user`.
- Qt/OpenGL: `libxcb-cursor0`, `libxcb-cursor-dev`, `libgl1-mesa-dev`, `libglu1-mesa-dev`, `mesa-common-dev`, `mesa-utils`, `freeglut3-dev`, `libglfw3-dev`, `libglew-dev`.
- Utilities: `ripgrep`, `fd-find`, `fzf`, `tree`, `htop`, `neovim`, `neofetch`, `ibus-unikey`, `qpdfview`, `cloud-guest-utils`, `gparted`.

## Zsh

`package/zsh.sh` installs:

- Oh My Zsh into `~/.oh-my-zsh`.
- `zsh-syntax-highlighting`.
- `zsh-autosuggestions`.
- Zsh as the default shell with `chsh -s "$(which zsh)"`.

`zsh/.zshrc` configures:

- Oh My Zsh theme: `robbyrussell`.
- Plugins: `git`, `zsh-autosuggestions`, `zsh-syntax-highlighting`.
- `~/.local/bin` in `PATH`.
- `nvim` as the default editor when available, otherwise `vim`.
- Short aliases: `work`, `ll`, `cls`, `gs`, `ga`, `gc`, `gp`, `gl`, `..`, `...`.

## WezTerm

`package/wezterm.sh` adds the `https://apt.fury.io/wez/` apt repository and installs the `wezterm` package.

`wezterm/.config/wezterm/wezterm.lua` configures:

- `JetBrainsMono Nerd Font Mono`, font size `12.5`, and disabled ligatures.
- Dark terminal colors, `0.9` background opacity, and a blinking bar cursor.
- Hidden tab bar and `10000` lines of scrollback.
- Default shell: `zsh`.
- Launcher entries for `Zsh`, `Bash`, and `Htop`.

Useful WezTerm key bindings:

| Key | Action |
| --- | --- |
| `Ctrl+Shift+C` | Copy |
| `Ctrl+Shift+V` | Paste |
| `Ctrl+Shift+P` | Command palette |
| `Ctrl+Shift+Space` | Quick select |
| `Ctrl+Shift+X` | Copy mode |
| `Ctrl+Shift+L` | Launcher |
| ``Alt+\`` | Split pane right |
| ``Alt+Shift+\`` | Split pane left |
| `Alt+-` | Split pane down |
| `Alt+Shift+-` | Split pane up |
| `Alt+Arrow` | Move focus between panes |
| `Alt+p` | Select pane |
| `Alt+Shift+P` | Swap with selected pane |
| `Alt+Shift+h/j/k/l` | Resize pane |
| `Alt+Enter` | Toggle pane zoom |
| `Alt+w` | Close current pane |

## Font

`package/font.sh` downloads JetBrainsMono Nerd Font from the latest `ryanoasis/nerd-fonts` release and extracts it into:

```text
~/.local/share/fonts/JetBrainsMonoNerdFont
```

It then runs `fc-cache` to refresh the font cache.

## Linking Configs With Stow

`install.sh` automatically links these packages into `$HOME`:

```bash
stow --dir "$PWD" --target "$HOME" zsh
stow --dir "$PWD" --target "$HOME" wezterm
```

You can also run this manually:

```bash
stow --dir "$PWD" --target "$HOME" zsh
stow --dir "$PWD" --target "$HOME" wezterm
```

To remove the links:

```bash
stow -D --dir "$PWD" --target "$HOME" zsh
stow -D --dir "$PWD" --target "$HOME" wezterm
```

If `~/.zshrc` or `~/.config/wezterm/wezterm.lua` already exists, Stow may report a conflict. Back up the existing files before linking this configuration.

## Run Individual Steps

If you do not want to run the full installer:

```bash
bash package/ubuntu.sh
bash package/font.sh
bash package/zsh.sh
bash package/wezterm.sh
```

## Notes

- Scripts use `set -e`, so they stop immediately on errors.
- `package/font.sh`, `package/wezterm.sh`, and `package/zsh.sh` download files from the internet.
- `package/zsh.sh` keeps an existing `.zshrc` during the Oh My Zsh install with `KEEP_ZSHRC=yes`, but the later Stow step can still conflict if a target file already exists.
- After changing the default shell with `chsh`, log out and back in or start a new session for the change to take effect.
