-- Pull in the wezterm API & configuration builder
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Theme & colors
config.color_scheme_dirs = {wezterm.config_dir .. "/colors"}
config.color_scheme = "dark-theme"

-- Fonts
config.font = wezterm.font {
	family = "JetBrainsMono Nerd Font Mono",
	harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
}
config.font_size = 12.5

-- Window
config.enable_tab_bar = false
config.window_decorations = "TITLE | RESIZE"

-- Cursor
config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_rate = 500

-- Background
config.window_background_opacity = 0.9

-- Default shell
config.default_prog = {"wsl.exe"}

-- and finally, return the configuration to wezterm
return config
