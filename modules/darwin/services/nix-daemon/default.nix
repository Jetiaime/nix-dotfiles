{
  lib,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.services.nix-daemon;
in {

  options.${namespace}.services.nix-daemon = {
    enable = mkBoolOpt false "Whether or not enable nix-daemon service.";
  };

  config = mkIf cfg.enable {
    services.nix-daemon.enable = true;
  };
}