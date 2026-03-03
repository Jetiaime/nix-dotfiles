{
  pkgs,
  user,
  nix-openclaw,
  ...
}:
{
  # 用户相关配置
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  # home-manager 配置
  home-manager = {
    useGlobalPkgs = true;
    users.${user} =
      {
        pkgs,
        config,
        lib,
        ...
      }:
      {
        # Note: nix-openclaw module has compatibility issues with current nixpkgs
        # For now, we'll install openclaw-gateway via nix-env instead
        # The module requires pkgs.openclaw which isn't in nixpkgs yet

        home = {
          enableNixpkgsReleaseCheck = false;
          packages = pkgs.callPackage ./packages.nix { } ++ [
            (pkgs.writeShellScriptBin "install-oh-my-opencode" ''
              #!/bin/bash
              set -e
              echo "Installing Oh My OpenCode..."
              bunx oh-my-opencode install
            '')
          ];
          stateVersion = "25.05";

          # 设置壁纸
          activation.setWallpaper = config.lib.dag.entryAfter [ "writeBoundary" ] ''
              $DRY_RUN_CMD /usr/bin/osascript << EOF
                tell application "System Events"
                  set desktopCount to count of desktops
                  repeat with desktopNumber from 1 to desktopCount
                    tell desktop desktopNumber
                      if desktopNumber is 1 then
                        set picture to "/etc/nix-darwin/resources/background/Rem.jpeg"
                      else
                        set picture to "/etc/nix-darwin/resources/background/astro-jelly.jpg"
                      end if
                    end tell
                  end repeat
                end tell
            EOF
          '';

          # 管理的配置文件
          file = {
            # Starship 提示符配置
            ".config/starship.toml".source =
              config.lib.file.mkOutOfStoreSymlink "/etc/nix-darwin/resources/starship/starship.toml";

            # WezTerm 终端模拟器配置
            ".config/wezterm" = {
              source = config.lib.file.mkOutOfStoreSymlink "/etc/nix-darwin/resources/wezterm";
              recursive = true;
            };

            # Lima 虚拟机配置
            ".lima/kind-arm64.yaml".source =
              config.lib.file.mkOutOfStoreSymlink "/etc/nix-darwin/resources/lima/kind-arm64.yaml";

            # OpenCode 配置
            ".config/opencode/opencode.json".source =
              config.lib.file.mkOutOfStoreSymlink "/etc/nix-darwin/resources/opencode/opencode.json";

            ".config/opencode/tui.json".source =
              config.lib.file.mkOutOfStoreSymlink "/etc/nix-darwin/resources/opencode/tui.json";

            # OhMyOpenCode 配置
            ".config/opencode/oh-my-opencode.json".source =
              config.lib.file.mkOutOfStoreSymlink "/etc/nix-darwin/resources/opencode/oh-my-opencode.json";
          };
        };

        # 合并对应的 programs
        programs = 
          (import ../shared/home-programs.nix { inherit user pkgs config; });

        xdg.configFile."Code/User/settings.json".text = ''
          {
            "[nix]": {
              "editor.defaultFormatter": "jnoortheen.nix-ide",
              "editor.tabSize": 2
            },
            "nix.server": "${pkgs.nil}/bin/nil"
          }
        '';

        # 合并对应的 services
        services = { } // (import ../shared/home-services.nix { inherit user pkgs config; });

        # 禁用 Home Manager 自动生成和安装 man 手册页
        manual.manpages.enable = false;
      };
  };

  # homebrew 配置
  homebrew = {
    enable = true;
    casks = pkgs.callPackage ./casks.nix { };
    brews = pkgs.callPackage ./brews.nix { };
    onActivation = {
      # 每次 darwin-rebuild 时自动 brew update
      autoUpdate = true;

      # 自动升级已安装的包
      upgrade = true;

      # 清理不在配置中的包（可选 "none", "uninstall", "zap"）
      cleanup = "uninstall";
    };
  };
}
