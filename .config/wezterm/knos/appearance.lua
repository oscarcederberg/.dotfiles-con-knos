local wezterm = require('wezterm')
local module = {}

local asset_home = os.getenv('HOME') .. '/.config/wezterm/assets/'

function module.apply(config)
  config.color_scheme = 'Gruvbox Dark (Gogh)'
  config.font = wezterm.font_with_fallback({
    'Comic Mono',
    'Noto Sans Mono',
    'Noto Color Emoji',
  })

  wezterm.on(
    'update-right-status',
    function(window, pane)
      local date = wezterm.strftime('%a %b %-d')

      window:set_right_status(
        wezterm.format {
          { Attribute = { Intensity = 'Bold' } },
          { Foreground = { AnsiColor = 'Green' } },
          { Text = window:active_workspace() },
          'ResetAttributes',
          { Attribute = { Intensity = 'Bold' } },
          { Text = '\\\\' },
          'ResetAttributes',
          { Attribute = { Intensity = 'Bold' } },
          { Foreground = { AnsiColor = 'Yellow' } },
          { Text = string.lower(date) },
        })
    end
  )

  config.use_fancy_tab_bar = false
  config.hide_tab_bar_if_only_one_tab = false
  config.window_background_opacity = 1.0
  config.inactive_pane_hsb = {
    saturation = 0.75,
    brightness = 0.66,
  }
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
end

return module
