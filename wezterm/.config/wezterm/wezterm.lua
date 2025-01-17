local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.font_size = 14

config.color_scheme = "kanagawa (Gogh)"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_decorations = "RESIZE"
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.cursor_blink_rate = 200
config.hide_tab_bar_if_only_one_tab = true

config.keys = {
  {
    key = 'w',
    mods = 'CMD',
    action = wezterm.action.DisableDefaultAssignment,
  }
}
-- config.enable_csi_u_key_encoding = true
config.check_for_updates = false
-- config.window_close_confirmation = "NeverPrompt"


return config
