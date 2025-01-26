{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.network.vpn.zerotierone;
in {
  options.${namespace}.programs.gui.network.vpn.zerotierone = {
    enable = mkBoolOpt false "Whether or not enable zerotierone.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      zerotierone
    ];
  };
}
