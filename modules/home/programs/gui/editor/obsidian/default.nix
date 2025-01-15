{
  lib,
  pkgs,
  config,
  system,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.snowfall.systems) isDarwin;
  inherit (lib.${namespace}) mkBoolOpt;
  
  cfg = config.${namespace}.programs.gui.editor.obsidian;
in {
  options.${namespace}.programs.gui.editor.obsidian = {
    enable = mkBoolOpt false "Whether or not enable obsidian.";
  };

  config = mkIf cfg.enable (
    if isDarwin system
    then {
      homebrew.casks = [ "obsidian" ];
    }
    else {
      home.packages = with pkgs; [ obsidian ];
    }
  );
}
