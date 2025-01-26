{
  lib,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkMerge mkEnableOption;

  cfg = config.${namespace}.system.physical;
in {
  options.${namespace}.system.physical = {
    enable = mkEnableOption "MacOS physical input.";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      system = {
        keyboard = {
          enableKeyMapping = true;
          remapCapsLockToEscape = true;
        };

        defaults = {
          ".GlobalPreferences"."com.apple.mouse.scaling" = 1.0;

          # trackpad
          trackpad = {
            ActuationStrength = 0;
            Clicking = true;
            FirstClickThreshold = 1;
            SecondClickThreshold = 1;
            TrackpadRightClick = true;
            TrackpadThreeFingerDrag = true;
          };

          NSGlobalDomain = {
            AppleKeyboardUIMode = 3;
            ApplePressAndHoldEnabled = false;

            KeyRepeat = 1;
            InitialKeyRepeat = 10;

            NSAutomaticCapitalizationEnabled = false;
            NSAutomaticDashSubstitutionEnabled = false;
            NSAutomaticQuoteSubstitutionEnabled = false;
            NSAutomaticPeriodSubstitutionEnabled = false;
            NSAutomaticSpellingCorrectionEnabled = false;
          };
        };
      };
    }
  ]);
}