local wezterm = require('wezterm')
local platform = require('utils.platform')()
local act = wezterm.action
local mux = wezterm.mux

local mod = {
    C_S = 'CTRL|SHIFT',
    C_SU = 'CTRL|SUPER',
}

if platform.is_mac then
    mod.SUPER = 'SUPER'
    mod.SUPER_REV = 'SUPER|SHIFT'
    mod.OPT_SUPER = 'OPT|SUPER'
elseif platform.is_win then
    -- TODO:
end

local leader = { key = 'Space', mods = 'SUPER|SHIFT' }

local keys = {
    --------------------------------
    --           GENERAL          --
    --------------------------------

    -- copy / paste --
    { key = 'c',   mods = 'SUPER',   action = act.CopyTo('Clipboard') },
    { key = 'v',   mods = 'SUPER',   action = act.PasteFrom('Clipboard') },

    -- functional
    { key = 'F3',  mods = 'NONE',    action = act.ShowLauncher },
    { key = 'F4',  mods = 'NONE',    action = act.ShowLauncherArgs({ flags = 'FUZZY|TABS' }) },
    { key = 'F5',  mods = 'NONE',    action = act.ShowLauncherArgs({ flags = 'FUZZY|WORKSPACES' }) },
    { key = 'F12', mods = 'NONE',    action = act.ShowDebugOverlay },

    { key = 'p',   mods = mod.C_S,   action = wezterm.action.ActivateCommandPalette },

    --------------------------------
    --         APPLICATION        --
    --------------------------------

    { key = 'q',   mods = mod.SUPER, action = wezterm.action.QuitApplication },

    --------------------------------
    --           SCREEN           --
    --------------------------------

    -- full screen
    { key = 'f',   mods = mod.C_SU,  action = act.ToggleFullScreen },

    --------------------------------
    --         WORKSPACES         --
    --------------------------------

    -- rename workspace name
    {
        key = 'n',
        mods = mod.C_S,
        action = act.PromptInputLine {
            description = wezterm.format {
                { Attribute = { Intensity = 'Bold' } },
                { Foreground = { AnsiColor = 'Fuchsia' } },
                { Text = 'Enter name for new workspace' },
            },
            action = wezterm.action_callback(function(window, pane, line)
                if line then
                    mux.rename_workspace(mux.get_active_workspace(), line)
                end
            end),
        },
    },

    --------------------------------
    --           WINDOWS          --
    --------------------------------

    -- spawn
    { key = 'n',   mods = mod.SUPER,     action = act.SpawnWindow },

    --------------------------------
    --            TAB             --
    --------------------------------

    -- navigation-GUI
    { key = 'Tab', mods = mod.C_S,       action = act.ActivateTabRelative(-1) },
    { key = 'Tab', mods = 'CTRL',        action = act.ActivateTabRelative(1) },

    -- navigation-VIM
    { key = '[',   mods = mod.SUPER_REV, action = act.ActivateTabRelative(-1) },
    { key = ']',   mods = mod.SUPER_REV, action = act.ActivateTabRelative(1) },

    -- move-VIM
    { key = '{',   mods = mod.C_S,       action = act.MoveTabRelative(-1) },
    { key = '}',   mods = mod.C_S,       action = act.MoveTabRelative(1) },

    -- select
    { key = '1',   mods = mod.SUPER,     action = act.ActivateTab(0) },
    { key = '2',   mods = mod.SUPER,     action = act.ActivateTab(1) },
    { key = '3',   mods = mod.SUPER,     action = act.ActivateTab(2) },
    { key = '4',   mods = mod.SUPER,     action = act.ActivateTab(3) },
    { key = '5',   mods = mod.SUPER,     action = act.ActivateTab(4) },
    { key = '6',   mods = mod.SUPER,     action = act.ActivateTab(5) },
    { key = '7',   mods = mod.SUPER,     action = act.ActivateTab(6) },
    { key = '8',   mods = mod.SUPER,     action = act.ActivateTab(7) },
    { key = '9',   mods = mod.SUPER,     action = act.ActivateTab(8) },

    -- spawn
    { key = 't',   mods = mod.SUPER,     action = act.SpawnTab('CurrentPaneDomain') },

    -- rename tab name
    {
        key = 'e',
        mods = mod.C_S,
        action = act.PromptInputLine {
            description = 'Enter new name for tab',
            action = wezterm.action_callback(function(window, pane, line)
                if line then
                    window:active_tab():set_title(line)
                end
            end),
        },
    },

    --------------------------------
    --            PANE            --
    --------------------------------

    -- zoom
    { key = 'Enter',      mods = mod.SUPER, action = act.TogglePaneZoomState },

    -- close
    { key = 'w',          mods = mod.SUPER, action = act.CloseCurrentPane({ confirm = false }) },

    -- navigation-GUI
    { key = 'UpArrow',    mods = mod.SUPER, action = act.ActivatePaneDirection('Up') },
    { key = 'DownArrow',  mods = mod.SUPER, action = act.ActivatePaneDirection('Down') },
    { key = 'LeftArrow',  mods = mod.SUPER, action = act.ActivatePaneDirection('Left') },
    { key = 'RightArrow', mods = mod.SUPER, action = act.ActivatePaneDirection('Right') },

    -- navigation-VIM
    { key = 'k',          mods = mod.SUPER, action = act.ActivatePaneDirection('Up') },
    { key = 'j',          mods = mod.SUPER, action = act.ActivatePaneDirection('Down') },
    { key = 'h',          mods = mod.SUPER, action = act.ActivatePaneDirection('Left') },
    { key = 'l',          mods = mod.SUPER, action = act.ActivatePaneDirection('Right') },

    -- split
    {
        key = 'h',
        mods = mod.OPT_SUPER,
        action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
    },
    {
        key = 'v',
        mods = mod.OPT_SUPER,
        action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
    },

    --------------------------------
    --         KEY TABLES         --
    --------------------------------

    -- resize font
    {
        key = 't',
        mods = 'LEADER',
        action = act.ActivateKeyTable({
            name = 'resize_font',
            one_shot = false,
            timemout_miliseconds = 1000,
        }),
    },
}

local key_tables = {
    resize_font = {
        { key = 'k',      action = act.IncreaseFontSize },
        { key = 'j',      action = act.DecreaseFontSize },
        { key = 'r',      action = act.ResetFontSize },
        { key = 'Escape', action = 'PopKeyTable' },
        { key = 'q',      action = 'PopKeyTable' },
    },
    resize_pane = {
        { key = 'k',      action = act.AdjustPaneSize({ 'Up', 1 }) },
        { key = 'j',      action = act.AdjustPaneSize({ 'Down', 1 }) },
        { key = 'h',      action = act.AdjustPaneSize({ 'Left', 1 }) },
        { key = 'l',      action = act.AdjustPaneSize({ 'Right', 1 }) },
        { key = 'Escape', action = 'PopKeyTable' },
        { key = 'q',      action = 'PopKeyTable' },
    },
}

--------------------------------
--            MOUSE           --
--------------------------------
local mouse_bindings = {
    -- 双击 Tab 栏重命名
    {
        event = { Down = { streak = 2, button = 'Left' } },
        mods = 'CTRL',
        action = wezterm.action_callback(function(window, pane)
            -- 弹出输入框
            window:perform_action(
                act.PromptInputLine {
                    description = wezterm.format {
                        { Attribute = { Intensity = 'Bold' } },
                        { Foreground = { AnsiColor = 'Fuchsia' } },
                        { Text = '重命名 Tab:' },
                    },
                    action = wezterm.action_callback(function(win, p, line)
                        if line and #line > 0 then
                            win:active_tab():set_title(line)
                        end
                    end),
                },
                pane
            )
        end),
    },
}

return {
    disable_default_key_bindings = true,
    leader = leader,
    keys = keys,
    key_tables = key_tables,
    mouse_bindings = mouse_bindings,
}
