{
  lib,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.vm.orbstack;
in {
  options.${namespace}.programs.gui.vm.orbstack = {
    enable = mkBoolOpt false "Whether to enable OrbStack.";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "orbstack" ];
  };
}
