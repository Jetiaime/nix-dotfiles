{
  lib,
  pkgs,
  namespace,
  ...
}: let
  inherit (lib.${namespace}) enabled;
in {
  ${namespace} = {
    user = {
      name = "teamo";
      email = "1157757077@qq.com";
      fullName = "Te Amo";
    };

    system = {
      enable = true;
      fonts = {
        enable = true;
        packages = with pkgs; [
          (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
        ];
      };

      ui = enabled;
      physical = enabled;      

      package-manager = {
        nix = enabled;
        homebrew = {
          enable = true;
          masEnable = true;
        };
      };

      stateVersion = 5;
    };
    
    programs = {
      cli = {
        enable = true;
        shell.zsh = enabled;
      };

      gui = {
        browser.zen = enabled;
        editor.cursor = enabled;
        manager.task = {
          super-productivity = enabled;
          ticktick = enabled;
        };
        music.netease = enabled;
        network.vpn.clash-verge-rev = enabled;
        version-control.github = enabled;
        vm.orbstack = enabled;
      };
    };
  };
}