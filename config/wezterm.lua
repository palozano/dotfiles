-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return 'Dark'
end

local function scheme_for_appearance(appearance)
	if appearance:find 'Dark' then
		return 'Batman'
	else
		-- return 'Builtin Solarized Light'
		return 'Builtin Tango Light'
	end
end

-- Themes that I liked:
-- Batman
-- Darcula
config.color_scheme = 'Darcula (base16)'
-- config.color_scheme = scheme_for_appearance(get_appearance())
config.font = wezterm.font('Iosevka Light', { weight = 'Light', italic = false })
config.font_size = 17.0

config.window_decorations = "RESIZE"

config.window_padding = {
	left = 20,
	right = 20,
	top = 20,
	bottom = 0,
}


-- and finally, return the configuration to wezterm
return config
