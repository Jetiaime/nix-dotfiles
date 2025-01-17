{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  
  cfg = config.${namespace}.programs.gui.windows.launcher.raycast;
in {
  options.${namespace}.programs.gui.windows.launcher.raycast = {
    enable = mkBoolOpt false "Whether or not enable raycast.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      raycast
    ];
  };
}
