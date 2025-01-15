{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  inherit (lib) types mkIf;
  inherit (lib.${namespace}) mkOpt mkStrOpt;

  cfg = config.${namespace}.user;
in {
  options.${namespace}.user = {
    name = mkStrOpt "" "The user name.";
    email = mkStrOpt "" "The user email.";
    fullName = mkStrOpt "" "The user full name.";
    uid = mkOpt (types.nullOr types.int) 1000 "The user uid.";
  };

  config = {
    assertions = [
      {
        assertion = cfg.name != "";
        message = "The name of the user is required.";
      }
    ];

    users.users.${cfg.name} = {
      uid = mkIf (cfg.uid != null) cfg.uid;
      shell = pkgs.zsh;
    };
  };
}
