{
  lib,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.manager.task.ticktick;
in {
  options.${namespace}.programs.gui.manager.task.ticktick = {
    enable = mkBoolOpt false "Whether to enable TickTick.";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "ticktick" ];
  };
}
