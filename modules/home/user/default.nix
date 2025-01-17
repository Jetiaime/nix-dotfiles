{
  lib,
  config,
  system,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkStrOpt mkBoolOpt;
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
    ];
    
    home = {
      username = cfg.name;
      homeDirectory = cfg.home;
    };
  };
}
