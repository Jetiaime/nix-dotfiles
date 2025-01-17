{
  lib,
  namespace,
  ...
}: let
  inherit (lib.${namespace}) enabled;
in {
  teamo = {
    # I don't know why it doesn't work.
    # home = {
    #   enable = true;
    #   stateVersion = "24.11";
    # };
    # user = {
    #   enable = true;
    #   email = "1157757077@qq.com";
    # };

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

  # It should be stay in `home/default.nix`, but it doesn't work, so I have to put it here.
  programs.home-manager = enabled;
  home.stateVersion = "24.11";
}
