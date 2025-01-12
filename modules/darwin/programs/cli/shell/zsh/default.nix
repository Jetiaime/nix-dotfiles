{
  lib,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;
  cfg = config.${namespace}.programs.cli.shell.zsh;
in {
  options.${namespace}.programs.cli.shell.zsh = {
    enable = mkBoolOpt false "Whether or not enable zsh configuration.";
  };

  config = mkIf cfg.enable {
    programs.zsh.enable = true;
  };
}