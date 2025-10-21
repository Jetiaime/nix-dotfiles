local wezterm = require('wezterm')
local gpu_adapters = require('utils.gpu_adapter')
local colors = require('colors.custom')

return {
    animation_fps = 60,                                                -- 最大动画帧率
    max_fps = 60,                                                      -- 最大显示帧率
    front_end = 'WebGpu',                                              -- 渲染前端
    webgpu_power_preference = 'HighPerformance',                       -- 配置了渲染前端为 `WebGpu` 时的电源选项
    webgpu_preferred_adapter = gpu_adapters:pick(),                    -- 

    -- color scheme
    colors = colors,                                                   -- 指定颜色调色的 scheme 方案

    -- background
    background = {                                                     -- 背景
        {
            source = { File = wezterm.GLOBAL.background },
        },
        {
            source = { Color = colors.background },
            height = '100%',
            width = '100%',
            opacity = 0.96,
        },
    },

    --------------------------------
    --         SCROLLBAR          --
    --------------------------------

    enable_scroll_bar = true,                                          -- 是否开启滚动条

    --------------------------------
    --            TAB             --
    --------------------------------

    enable_tab_bar = true,                                             -- 是否启动标签栏
    use_fancy_tab_bar = true,                                          -- 是否使用 fancy 标签栏
    tab_bar_at_bottom = false,                                         -- 是否将标签栏放置在下方
    show_tab_index_in_tab_bar = false,                                 -- 是否展示 tab 的序号
    hide_tab_bar_if_only_one_tab = true,                               -- 是否当仅有一个 tab 式隐藏标题栏
    switch_to_last_active_tab_when_closing_tab = true,                 -- 是否切换至最后的一个 tab 当关闭该 tab 时
    tab_max_width = 25,                                                -- tab 的最大宽度

    --------------------------------
    --           WINDOW           --
    --------------------------------

    window_close_confirmation = 'NeverPrompt',                         -- 取消窗口关闭提示
    window_decorations = "RESIZE",                                     -- 取消窗口标题栏
    window_padding = {                                                 -- 窗口大小填充
        left = 5,
        right = 10,
        top = 12,
        bottom = 7,
    },
    window_frame = {
        active_titlebar_bg = '#090909',
    },
    inactive_pane_hsb = {
        saturation = 0.9,
        brightness = 0.65,
    },
    
    --------------------------------
    --           MAC OS           --
    --------------------------------
    native_macos_fullscreen_mode = true,                               -- 使用 MacOS 的全屏模式

}
