{
  lib,
  pkgs,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;

  cfg = config.${namespace}.system.fonts;
in
{
  imports = [ (lib.snowfall.fs.get-file "modules/common/system/font/default.nix") ];

  config = mkIf cfg.enable {
    fonts.packages = cfg.packages;
  };
}
