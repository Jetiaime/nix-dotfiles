local wezterm = require('wezterm')

local SchemePicker = {}

function SchemePicker:pick()
  if wezterm.gui.get_appearance():find "Dark" then
    return "Catppuccin Mocha"
  else
    return "Catppuccin Latte"
  end
end

return SchemePicker
