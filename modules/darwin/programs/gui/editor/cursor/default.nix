{
  lib,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.editor.cursor;
in {
  options.${namespace}.programs.gui.editor.cursor = {
    enabled = mkBoolOpt false "Whether to enable Cursor.";
  };

  config = mkIf cfg.enabled {
    homebrew.casks = [ "cursor" ];
  };
}
