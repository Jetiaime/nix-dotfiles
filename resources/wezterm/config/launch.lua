local platform = require('utils.platform')()

local options = {
   default_prog = {},
   launch_menu = {},
}

if platform.is_win then
   options.default_prog = { 'pwsh' }
   options.launch_menu = {
      { label = 'PowerShell Core',    args = { 'pwsh' } },
      { label = 'PowerShell Desktop', args = { 'powershell' } },
      { label = 'Command Prompt',     args = { 'cmd' } },
      { label = 'Nushell',            args = { 'nu' } }
   }
elseif platform.is_mac then
   -- local HOME_BREW_PATH = '/opt/homebrew/bin'
   options.default_prog = { 'zsh' }
   options.launch_menu = {
      { label = 'Zsh',  args = { 'zsh' } },
      { label = 'Bash', args = { 'bash' } },
   }
elseif platform.is_linux then
   options.default_prog = { 'zsh' }
   options.launch_menu = {
      { label = 'Zsh',  args = { 'zsh' } },
      { label = 'Bash', args = { 'bash' } },
   }
end

return options
