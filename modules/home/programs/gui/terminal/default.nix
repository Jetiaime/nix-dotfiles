{
  lib,
  inputs,
  config,
  system,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.terminal.wezterm;
in {
  options.${namespace}.programs.gui.terminal.wezterm = {
    enable = mkBoolOpt false "Whether or not to manage WezTerm.";
  };

  config = mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      package = inputs.wezterm.packages.${system}.default;
      extraConfig = ''
        -- 添加当前配置目录到 Lua 的搜索路径
        package.path = string.format(
          "%s/extraConfig/?.lua;%s",
          debug.getinfo(1).source:match("@?(.*/)"),
          package.path
        )

        -- 导入主配置模块
        local config = require('wezterm')
        return config
      '';
    };

    # 复制配置文件到 home-manager 管理的位置
    home.file = {
      ".config/wezterm/" = {
        source = ./extraConfig;
        recursive = true;  # 确保复制整个目录及其内容
      };
    };
  };
}

