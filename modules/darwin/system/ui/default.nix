{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.${namespace}.system.ui;
in {
  options.${namespace}.system.ui = {
    enable = mkEnableOption "Whether to enable MacOS UI."; 
  };

  config = mkIf cfg.enable {
    system.defaults = {

      ############################################################
      # System preferences.
      ############################################################

      loginwindow = {
        GuestEnabled = false;
        SHOWFULLNAME = false;
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        CreateDesktop = false;
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "Nlsv";
        QuitMenuItem = true;
        ShowStatusBar = false;
        _FXShowPosixPathInTitle = false;
      };

      dock = {
        autohide = false;
        mineffect = "scale";
        minimize-to-application = true;
        mouse-over-hilite-stack = true;
        mru-spaces = false;
        orientation = "bottom";
        show-process-indicators = true;
        show-recents = false;
        showhidden = false;
        static-only = false;
        tilesize = 50;

        wvous-tl-corner = 2;
        wvous-tr-corner = 12;
        wvous-bl-corner = 14;
        wvous-br-corner = 4;

        persistent-apps = [
          "/System/Applications/Launchpad.app"
          "/System/Applications/Calendar.app"
          # {
          #   spacer = {
          #     small = true;
          #   };
          # }
          "/Applications/TickTick.app"
          "/Applications/Super Productivity.app"
          # "~/Applications/Home\ Manager\ Apps/WezTerm.app"
          "/nix/store/harnalxspcysn96xgv56rx96vnqwg3xi-wezterm/Applications/WezTerm.app"
          # "~/Applications/Home Manager Apps/Applications/Obsidian.app"
          "/nix/store/vlag9ljc09lq1h4p7lmrihdn51lzy33z-obsidian-1.7.6/Applications/Obsidian.app"
          "/Applications/OrbStack.app"
          # "~/Applications/Home Manager Apps/IntelliJ IDEA Ultimate.app"
          "/nix/store/xlwpx2g2vqkprnr3nzj7y76lnb1sdq3c-idea-ultimate-2024.3.1.1/Applications/IntelliJ IDEA.app"
          # "~/Applications/Home Manager Apps/PyCharm.app"
          "/nix/store/q50m0w92sy09fvv2fv95m6ks6vyzliii-pycharm-professional-2024.3.1.1/Applications/PyCharm.app"
          "/Applications/Cursor.app"
          "/Applications/Zen Browser.app"
          "/System/Applications/Music.app"
          "/Applications/NeteaseMusic.app"
        ];

        persistent-others = [
          "~/Downloads"
        ];
      };

      menuExtraClock = {
        FlashDateSeparators = false;
        Show24Hour = true;
        ShowDate = 1;
        ShowDayOfWeek = true;
        ShowSeconds = true;
      };

      screencapture = {
        disable-shadow = true;
        location = "~/Pictures/Screenshots";
        type = "png";
      };

      # spaces.spans-displays = !config.services.yabai.enable;

      NSGlobalDomain = {
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.sound.beep.volume" = 0.0;
        AppleShowAllExtensions = true;
        AppleShowScrollBars = "Automatic";
        NSAutomaticWindowAnimationsEnabled = false;
        _HIHideMenuBar = false;
      };

      ############################################################
      # Custom user preferences.
      ############################################################

      CustomUserPreferences = {
        finder = {
          DisableAllAnimations = true;
          ShowExternalHardDrivesOnDesktop = false;
          ShowHardDrivesOnDesktop = false;
          ShowMountedServersOnDesktop = false;
          ShowRemovableMediaOnDesktop = false;
          _FXSortFoldersFirst = true;
        };

        NSGlobalDomain = {
          AppleSpacesSwitchOnActivate = false;
        };
      };
    };
  };
}