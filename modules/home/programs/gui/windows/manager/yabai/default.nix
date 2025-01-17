{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkMerge;
  inherit (lib.${namespace}) mkStrOpt mkBoolOpt;

  cfg = config.${namespace}.programs.gui.windows.manager.yabai;
in {
  options.${namespace}.programs.gui.windows.manager.yabai = {
    enable = mkBoolOpt false "Whether or not enable windows manager.";
    config = mkStrOpt "" "The configuration of yabai.";

    skhdEnable = mkBoolOpt false "Whether or not enable skhd.";
    skhdConfig = mkStrOpt "" "The configuration of skhd.";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      home.packages = with pkgs; [
        yabai
      ];
    }

    (mkIf cfg.skhdEnable {
      home.packages = with pkgs; [
        skhd
      ];
    })
  ]);
}
