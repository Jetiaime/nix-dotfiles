{
  lib,
  namespace,
  ...
}: let
  inherit (lib.${namespace}) mkAttrsOpt;

in {
  options.${namespace}.home = {
    file = mkAttrsOpt {} "A set of files to be managed by home-manager's <option>home.file</option>.";
    configFile = mkAttrsOpt {} "A set of config files to be managed by home-manager's <option>home.configFile</option>.";
    extraConfig = mkAttrsOpt {} "Options to pass directly to home-manager.";
    homeConfig = mkAttrsOpt {} "Final configuration for home-manager.";
  };

  config = {

    home-manager = {
      backupFileExtension = "hm.old";
      useGlobalPkgs = true;
      useUserPackages = true;
      verbose = true;
    };
  };
}
