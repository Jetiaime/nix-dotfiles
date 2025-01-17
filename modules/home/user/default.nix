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

  cfg = config.${namespace}.user;
in {
  options.${namespace}.user = {
    enable = mkBoolOpt false "Whether or not enable user configuration.";
    name =  mkStrOpt config.snowfallorg.user.name "The name of the user.";
    email = mkStrOpt "" "The email address of the user.";
    home = mkStrOpt (
      if is-darwin system
      then "/Users/${cfg.name}"
      else "/home/${cfg.name}"
    ) "The home directory of the user.";
    stateVersion = mkStrOpt "" "The state version of the home configuration.";
  };

  config = mkIf cfg.enable {

    assertions = [
      {
        assertion = cfg.name != "";
        message = "name is required";
      }
      {
        assertion = cfg.home != "";
        message = "home is required";
      }
      {
        assertion = cfg.stateVersion != "";
        message = "stateVersion is required";
      }
    ];
    
    # put it here for now, because it doesn't work in `home/default.nix`.
    programs.home-manager = enabled;

    home = {
      username = cfg.name;
      homeDirectory = cfg.home;
      stateVersion = cfg.stateVersion;
    };
  };
}
