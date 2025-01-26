{
  lib,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.browser.zen;
in {
  options.${namespace}.programs.gui.browser.zen = {
    enable = mkBoolOpt false "Whether to enable Zen Browser.";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "zen-browser" ];
  };
}
