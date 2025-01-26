{
  lib,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.network.vpn.clash-verge-rev;
in {
  options.${namespace}.programs.gui.network.vpn.clash-verge-rev = {
    enable = mkBoolOpt false "Whether or not enable clash-verge-rev configuration.";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [
      "clash-verge-rev"
    ];
  };
}