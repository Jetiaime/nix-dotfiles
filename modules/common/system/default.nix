{
  lib,
  inputs,
  config,
  namespace,
  ...
}: let
  inherit (lib) types mkIf;
  inherit (lib.${namespace}) mkOpt mkBoolOpt;

  cfg = config.${namespace}.system;
in {
  
  options.${namespace}.system = {
    enable = mkBoolOpt false "Whether or not enable system configuration.";
    stateVersion = mkOpt (types.oneOf [types.str types.int]) null "The state version of the system.";
  };
  
  config = mkIf cfg.enable {
    system = {
      stateVersion = cfg.stateVersion;

      # Set Git commit hash for darwin-version.
      configurationRevision = inputs.rev or inputs.dirtyRev or null;
    };
  };
}