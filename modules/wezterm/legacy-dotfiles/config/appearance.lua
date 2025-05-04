local wezterm = require("wezterm")

local config = {}

config.font = wezterm.font("DejaVuSansM Nerd Font Mono")
config.font_size = 14.0

config.window_decorations = "RESIZE"
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.adjust_window_size_when_changing_font_size = false
config.window_padding = {
	top = 8,
	bottom = 8,
	left = 8,
	right = 8,
}
config.default_cursor_style = "BlinkingBar"

config.front_end = "WebGpu"

return config
