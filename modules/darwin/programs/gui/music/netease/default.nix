{
  lib,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.music.netease;
in {
  options.${namespace}.programs.gui.music.netease = {
    enable = mkBoolOpt false "Whether to enable NetEase Music.";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "neteasemusic" ];
  };
}
