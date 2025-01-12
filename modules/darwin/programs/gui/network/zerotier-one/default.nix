{
  lib,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.network.zerotier-one;
in {
  options.${namespace}.programs.gui.network.zerotier-one = {
    enable = mkBoolOpt false "Whether or not enable zerotier-one configuration.";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [
      "zerotier-one"
    ];
  };
}