{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.terminal.ghostty;
in {
  options.${namespace}.programs.gui.terminal.ghostty = {
    enable = mkBoolOpt false "Whether or not enable ghostty.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ghostty
    ];
  };
}
