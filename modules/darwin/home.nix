{
  lib,
  pkgs,
  user,
  config,
  home-manager,
  ...
}: {
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
    users.${user} = { pkgs, config, lib, ... }: {
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = pkgs.callPackage ./packages.nix {};
        stateVersion = "25.05";
        
        # 设置壁纸
        activation.setWallpaper = config.lib.dag.entryAfter ["writeBoundary"] ''
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
          ".config/wezterm" = {
            source = config.lib.file.mkOutOfStoreSymlink "/etc/nix-darwin/resources/wezterm";
            recursive = true;
          };
        };
      };
      
      # 合并对应的 programs
      programs = {} // (import ../shared/programs.nix { inherit user pkgs config; });
      
      # 合并对应的 services
      # services = {} // (import ../shared/services.nix { inherit user pkgs config; });

      # 禁用 Home Manager 自动生成和安装 man 手册页
      manual.manpages.enable = false;
    };
  };
  
  # homebrew 配置
  homebrew = {
    enable = true;
    casks = pkgs.callPackage ./casks.nix {};
  };
}
