{
  lib,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.manager.task.super-productivity;
in {
  options.${namespace}.programs.gui.manager.task.super-productivity = {
    enable = mkBoolOpt false "Whether to enable Super-Productivity.";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "superproductivity" ];
  };
}
