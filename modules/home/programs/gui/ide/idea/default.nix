{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.ide.idea;
in {
  options.${namespace}.programs.gui.ide.idea = {
    enable = mkBoolOpt false "Whether or not enable idea.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      jetbrains.idea-ultimate
    ];
  };
}
