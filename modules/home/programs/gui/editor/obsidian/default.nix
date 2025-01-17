{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;
  
  cfg = config.${namespace}.programs.gui.editor.obsidian;
in {
  options.${namespace}.programs.gui.editor.obsidian = {
    enable = mkBoolOpt false "Whether or not enable obsidian.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      obsidian
    ];
  };
}
