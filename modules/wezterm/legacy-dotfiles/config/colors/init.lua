local macchiato_palette = require("config.colors.catppuccin_macchiato")
local config = {}

--local background = macchiato_palette.crust.hex
local background = "#1a1a1a"

config.color_scheme = "Catppuccin Macchiato"
config.colors = {
	background = background,
	tab_bar = {
		background = background,
		active_tab = {
			bg_color = "#fff1a4",
			fg_color = background,
			intensity = "Bold",
			underline = "Single",
		},
		inactive_tab = {
			fg_color = macchiato_palette.overlay0.hex,
			bg_color = background,
			italic = true,
		},
	},
}
config.window_background_opacity = 0.83
config.macos_window_background_blur = 24

return config
