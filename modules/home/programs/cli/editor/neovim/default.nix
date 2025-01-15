{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let 
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOption;

  cfg = config.${namespace}.programs.cli.editor.neovim;
in {
  options.${namespace}.programs.cli.editor.neovim = {
    enable = mkBoolOption "Whether to enable neovim";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      neovim
    ];
  };
}

