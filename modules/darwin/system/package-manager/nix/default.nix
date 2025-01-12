{
  lib,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.${namespace}.system.package-manager.nix;
in {

  imports = [ (lib.snowfall.fs.get-file "modules/common/system/package-manager/nix/default.nix") ];

  config = mkIf cfg.enable {

    nixpkgs.hostPlatform = "aarch64-darwin";

    nix = {
      # Options that aren't supported through nix-darwin
      extraOptions = ''
        # bail early on missing cache hits.
        connect-timeout = 10
        keep-going = true
      '';

      gc = {
        interval = {
          Day = 7;
          Hour = 3;
        };

        user = config.${namespace}.user.name;
      };

      optimise = {
        interval = {
          Day = 7;
          Hour = 4;
        };

        user = config.${namespace}.user.name;
      };
    };
  };
}
