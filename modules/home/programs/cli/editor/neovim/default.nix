{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let 
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.cli.editor.neovim;
in {
  options.${namespace}.programs.cli.editor.neovim = {
    enable = mkBoolOpt false "Whether to enable neovim";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      neovim
    ];
  };
}

