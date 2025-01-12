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
    name = mkStrOpt "teamo" "The user name.";
    email = mkStrOpt "1157757077@qq.com" "The user email.";
    fullName = mkStrOpt "Teamo" "The user full name.";
    uid = mkOpt (types.nullOr types.int) 1000 "The user uid.";
  };

  config = {
    users.users.${cfg.name} = {
      uid = mkIf (cfg.uid != null) cfg.uid;
      shell = pkgs.zsh;
    };
  };
}
