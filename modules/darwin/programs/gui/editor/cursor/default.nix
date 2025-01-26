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
    enable = mkBoolOpt false "Whether to enable Cursor.";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "cursor" ];
  };
}
