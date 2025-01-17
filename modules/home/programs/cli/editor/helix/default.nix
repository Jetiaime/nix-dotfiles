{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let 
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.cli.editor.helix;
in {
  options.${namespace}.programs.cli.editor.helix = {
    enable = mkBoolOpt false "Whether to enable helix";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      helix
    ];
  };
}
