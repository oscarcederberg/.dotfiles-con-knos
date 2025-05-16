local wezterm = require('wezterm')

local appearance = require('knos.appearance')
local bindings = require('knos.bindings')
local settings = require('knos.settings')

local module = {}

function module.apply_to_config(config)
  wezterm.log_info('applying knos')
  appearance.apply(config)
  bindings.apply(config)
  settings.apply(config)
end

return module
