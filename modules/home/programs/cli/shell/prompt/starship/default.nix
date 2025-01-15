{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let 
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOption;

  cfg = config.${namespace}.programs.cli.shell.prompt.starship;
in {
  options.${namespace}.programs.cli.shell.prompt.starship = {
    enable = mkBoolOption "Whether to enable starship";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      starship
    ];
  };
}
