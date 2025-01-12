{
  lib,
  inputs,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.system.package-manager.homebrew;
in {
  # nix-homebrew 
  imports = [(inputs.nix-homebrew.darwinModules.nix-homebrew {
    inherit lib;
    nix-homebrew = {
      enable = cfg.enable;
      enableRosetta = true;
      user = config.${namespace}.user.name;
      autoMigrate = true;
      # Cannot use `brew tap` to add taps
      mutableTaps = true;
    };
  })];

  options.${namespace}.system.package-manager.homebrew = {
    enable = mkBoolOpt false "Whether or not to manage homebrew configuration.";
    masEnable = mkBoolOpt false "Whether or not to manage mas configuration.";
  };

  # nix-darwin homebrew config
  config = mkIf cfg.enable {
    environment.variables = {
      HOMEBREW_BAT = "1";
      HOMEBREW_NO_ANALYTICS = "1";
      HOMEBREW_NO_INSECURE_REDIRECT = "1";
    };

    homebrew = {
      enable = cfg.enable;

      global = {
        brewfile = true;
        autoUpdate = true;
      };

      onActivation = {
        autoUpdate = true;
        cleanup = "uninstall";
        upgrade = true;
      };

      taps = [
        "homebrew/bundle"
        "homebrew/services"
      ];
    };
  };
}
