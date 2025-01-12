local Config = require('config')

-- 随机背景
require('utils.backdrops'):set_files():random()

require('events.right-status').setup()
require('events.new-tab-button').setup()

return Config:init()
    :append(require('config.appearance'))      -- 外观
    :append(require('config.fonts'))           -- 字体配置
    :append(require('config.bindings'))        -- 快捷键
    :append(require('config.general'))         -- 通用
    :append(require('config.domains'))         -- 
    :append(require('config.launch'))          -- 启动项
    .options
