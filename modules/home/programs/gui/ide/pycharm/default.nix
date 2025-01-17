{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.ide.pycharm;
in {
  options.${namespace}.programs.gui.ide.pycharm = {
    enable = mkBoolOpt false "Whether or not enable pycharm.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      jetbrains.pycharm-professional
    ];
  };
}
