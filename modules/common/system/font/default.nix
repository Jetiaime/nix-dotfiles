{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  inherit (lib) types mkIf;
  inherit (lib.${namespace}) mkOpt mkStrOpt mkBoolOpt;

  cfg = config.${namespace}.system.fonts;

in {
  options.${namespace}.system.fonts = with types; {
    enable = mkBoolOpt false "Whether or not to manage fonts.";

    packages = with pkgs; mkOpt (listOf package) [
      # Desktop Fonts
      corefonts    # MS fonts
      b612         # high legibility
      material-icons
      material-design-icons
      work-sans
      comic-neue
      source-sans
      inter
      lexend

      # Emojis
      noto-fonts-color-emoji
      twemoji-color-font

      # Nerd Fonts
      nerdfonts.caskaydia-cove
      nerdfonts.iosevka
      nerdfonts.monaspace
      nerdfonts.symbols-only
      (nerdfonts.override {
        fonts = [ "JetBrainsMono" ];
      })
    ] "Custom font packages to install.";

    default = mkStrOpt "MonaspiceNe Nerd Font" "Default font name";
  };
  
  config = mkIf cfg.enable {
    environment.variables = {
      # Enable icons in tooling since we have nerdfonts.
      LOG_ICONS = "true";
    };
  };
}