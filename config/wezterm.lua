-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = 'Batman'
config.font = wezterm.font('Iosevka Light', { weight = 'Light', italic = false })
config.font_size = 17.0


-- and finally, return the configuration to wezterm
return config
