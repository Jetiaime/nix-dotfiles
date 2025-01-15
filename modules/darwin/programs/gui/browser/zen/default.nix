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
    enabled = mkBoolOpt false "Whether to enable Browser Zen.";
  };

  config = mkIf cfg.enabled {
    homebrew.casks = [ "zen-browser" ];
  };
}

