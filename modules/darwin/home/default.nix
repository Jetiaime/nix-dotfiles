{
  lib,
  config,
  options,
  namespace,
  ...
}: let
  inherit (lib.${namespace}) mkAttrsOpt;
in
{

  options.${namespace}.home = {
    file = mkAttrsOpt { } "A set of files to be managed by home-manager's <option>home.file</option>.";
    configFile =
      mkAttrsOpt { }
        "A set of files to be managed by home-manager's <option>xdg.configFile</option>.";
    extraOptions = mkAttrsOpt { } "Options to pass directly to home-manager.";
    homeConfig = mkAttrsOpt { } "Final config for home-manager.";
  };

  config = {
    ${namespace}.home.extraOptions = {
      home.file = lib.mkAliasDefinitions options.${namespace}.home.file;
      xdg.enable = true;
      xdg.configFile = lib.mkAliasDefinitions options.${namespace}.home.configFile;
    };

    snowfallorg.users.${config.${namespace}.user.name}.home.config =
      lib.mkAliasDefinitions
        options.${namespace}.home.extraOptions;

    home-manager = {
      # enables backing up existing files instead of erroring if conflicts exist
      backupFileExtension = "hm.old";

      useGlobalPkgs = true;
      useUserPackages = true;

      verbose = true;
    };
  };
}