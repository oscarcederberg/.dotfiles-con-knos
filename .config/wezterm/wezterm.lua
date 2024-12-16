local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local knos_config = wezterm.plugin.require
    'https://github.com/oscarcederberg/knos-config.wezterm'
local asset_home = os.getenv("HOME") .. "/.config/wezterm/assets/"

knos_config.apply_to_config(config)

wezterm.on(
  'update-right-status',
  function(window, pane)
    local date = wezterm.strftime '%a %b %-d'

    window:set_right_status(
      wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Green' } },
        { Text = window:active_workspace() },
        'ResetAttributes',
        { Attribute = { Intensity = 'Bold' } },
        { Text = "\\\\" },
        'ResetAttributes',
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Yellow' } },
        { Text = string.lower(date) },
      })
  end
)

config.font = wezterm.font_with_fallback({
  "ComicMono",
  "Noto Sans Mono",
  "Noto Color Emoji"
})

-- Turn off transparency
config.window_background_opacity = 1.0
config.colors = {
  split = '#26a269'
}

config.background = {
  {
    source = {
      File = asset_home .. 'background.png'
    },
    repeat_x = 'NoRepeat',
    repeat_y = 'NoRepeat',
    opacity = 1,
    height = '100%',
    width = '100%',
  },
  {
    source = {
      File = {
        path = asset_home .. 'subin.gif',
        speed = 1.2,
      },
    },
    attachment = 'Fixed',
    repeat_x = 'NoRepeat',
    repeat_y = 'NoRepeat',
    vertical_align = 'Bottom',
    opacity = 0.75,
    height = 48,
    width = 1440,
  }
}

return config
