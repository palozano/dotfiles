local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.colors = {
  foreground = "#c8d3f5",
  background = "#222436",
  cursor_border = "#c8d3f5",
  cursor_fg = "#222436",
  selection_bg = "#2d3f76",
  selection_fg = "#c8d3f5",
  split = "#82aaff",
  compose_cursor = "#ff966c",
  scrollbar_thumb = "#2f334d",

  ansi = { "#1b1d2b", "#ff757f", "#c3e88d", "#ffc777", "#82aaff", "#c099ff", "#86e1fc", "#828bb8" },
  brights = { "#444a73", "#ff8d94", "#c7fb6d", "#ffd8ab", "#9ab8ff", "#caabff", "#b2ebff", "#c8d3f5" },

  tab_bar = {
    inactive_tab_edge = "#1e2030",
    background = "#222436",
    active_tab = {
      fg_color = "#1e2030",
      bg_color = "#82aaff",
    },
    inactive_tab = {
      fg_color = "#545c7e",
      bg_color = "#2f334d",
    },
    inactive_tab_hover = {
      fg_color = "#82aaff",
      bg_color = "#2f334d",
    },
    new_tab_hover = {
      fg_color = "#82aaff",
      bg_color = "#222436",
    },
    new_tab = {
      fg_color = "#82aaff",
      bg_color = "#222436",
    },
  },
  cursor_bg = '#FFA500',
  visual_bell = '#202020',
}

config.font = wezterm.font('Iosevka Light', { weight = 'Light' })
config.font_size = 17.5

config.window_decorations = "RESIZE"

config.window_padding = {
  left = 20,
  right = 20,
  top = 20,
  bottom = 0,
}

config.audible_bell = "Disabled"
config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 150,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 150,
}

config.hide_tab_bar_if_only_one_tab = true

local act = wezterm.action

config.keys = {
  -- Rebind OPT-Left, OPT-Right as ALT-b, ALT-f respectively to match Terminal.app behavior
  {
    key = 'LeftArrow',
    mods = 'OPT',
    action = act.SendKey {
      key = 'b',
      mods = 'ALT',
    },
  },
  {
    key = 'RightArrow',
    mods = 'OPT',
    action = act.SendKey {
      key = 'f',
      mods = 'ALT'
    },
  },
}
return config
