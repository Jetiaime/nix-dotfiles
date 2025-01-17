{
  lib,
  config,
  system,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkStrOpt mkBoolOpt enabled;
  inherit (lib.snowfall.system) is-darwin;

  cfg = config.${namespace}.home;
  username = config.snowfallorg.user.name;
in {
  options.${namespace}.home = {
    enable = mkBoolOpt false "Whether or not enable home configuration.";
    stateVersion = mkStrOpt "" "The state version of the home configuration.";
    home = mkStrOpt (
      if is-darwin system
      then "/Users/${username}"
      else "/home/${username}"
    ) "The home directory of the user.";
  };

  config = mkIf cfg.enable {
    programs.home-manager = enabled;
    
    home = {
      inherit username;

      homeDirectory = cfg.home;
      stateVersion = cfg.stateVersion;
    };
  };
}

