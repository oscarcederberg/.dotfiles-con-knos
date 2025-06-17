local wezterm = require('wezterm')
local config = wezterm.config_builder()
local knos = require('knos')

knos.apply_to_config(config)

return config
