{
  lib,
  namespace,
  ...
}: let
  inherit (lib.${namespace}) enabled;
in {
  teamo = {
    # home = {
    #   enable = true;
    #   stateVersion = "24.11";
    # };

    user = {
      enable = true;
      email = "1157757077@qq.com";
      stateVersion = "24.11";
    };

    programs = {
      cli = {
        editor = {
          neovim = enabled;
          helix = enabled;
        };

        shell = {
          prompt = {
            starship = enabled;
          };
        };
      };

      gui = {
        editor = {
          obsidian = enabled;
          vscode = enabled;
        };

        terminal.wezterm = enabled;
        windows.launcher.raycast = enabled;
      };
    };
  };
}
