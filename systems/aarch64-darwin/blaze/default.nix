{
  lib,
  namespace,
  ...
}: let
  inherit (lib.${namespace}) enabled;
in {
  ${namespace} = {
    system = {
      enable = true;
      stateVersion = 5;

      package-manager = {
        nix = enabled;
        homebrew = {
          enable = true;
          masEnable = true;
        };
      };
    };
    
    programs = {
      cli = {
        enable = true;
        shell.zsh = enabled;
      };

      gui = {
        network = {
          zerotier-one = enabled;
          clash-verge-rev = enabled;
        };
        
        version-control.github = enabled;
      };
    };
  };
}
