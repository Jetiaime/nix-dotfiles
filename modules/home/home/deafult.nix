{
  lib,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkStrOpt mkBoolOpt enabled;

  cfg = config.${namespace}.home;
in {
  options.${namespace}.home = {
    enable = mkBoolOpt false "Whether or not enable home configuration.";
    stateVersion = mkStrOpt "" "The state version of the home configuration.";
  };

  config = mkIf cfg.enable {
    programs.home-manager = enabled;
    home.stateVersion = cfg.stateVersion;
  };
}
