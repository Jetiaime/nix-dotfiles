  {
  lib,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.version-control.github;
in {
  options.${namespace}.programs.gui.version-control.github = {
    enable = mkBoolOpt false "Whether or not to manage GitHub.";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "github" ];
  };
}
