local wezterm = require("wezterm")

local config = {}
config.keys = {
	-- restore clear buffer from iTerm2
	{
		key = "k",
		mods = "SUPER",
		action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
	},
	{
		key = "k",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
	},
	-- command palette to cmd+shift+p
	{
		key = "p",
		mods = "SUPER|SHIFT",
		action = wezterm.action.ActivateCommandPalette,
	},
}

config.enable_kitty_keyboard = false

return config
