local utils = require("_utils")

local config = utils.merge_all(
	require("config.keybinds"),
	require("config.colors"),
	require("config.appearance"),
	require("local"),
	-- it doesn't work without this. I don't know why.
	{}
)

return config
