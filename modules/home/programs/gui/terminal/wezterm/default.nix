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
    enable = mkBoolOpt false "Whether or not to enable WezTerm.";
  };

  config = mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      package = inputs.wezterm.packages.${system}.default;
    };

    home.file.".config/wezterm" = {
      source = ./extraConfig;
      recursive = true;
    };
  };
}

