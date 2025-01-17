{
  lib,
  config,
  system,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkStrOpt mkBoolOpt;
  inherit (lib.snowfall.systems) isDarwin;

  cfg = config.${namespace}.user;
in {
  options.${namespace}.user = {
    enable = mkBoolOpt false "Whether or not enable user configuration.";
    name =  mkStrOpt config.snowfall.user.name "The name of the user.";
    email = mkStrOpt "" "The email address of the user.";
    home = mkStrOpt (
      if isDarwin system
      then "/Users/${cfg.name}"
      else "/home/${cfg.name}"
    ) "The home directory of the user.";
  };

  config = mkIf cfg.enable {
    home = {
      username = cfg.name;
      homeDirectory = cfg.home;
    };
  };
}
