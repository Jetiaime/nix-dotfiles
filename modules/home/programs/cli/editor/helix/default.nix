{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let 
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOption;

  cfg = config.${namespace}.programs.cli.editor.helix;
in {
  options.${namespace}.programs.cli.editor.helix = {
    enable = mkBoolOption "Whether to enable helix";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      helix
    ];
  };
}
