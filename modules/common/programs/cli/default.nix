{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.cli;
in {
  options.${namespace}.programs.cli = {
    enable = mkBoolOpt false "Whether or not enable cli configuration.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bat         # A cat(1) clone with wings
      coreutils   # GNU core utilities
      curl        # Curl
      eza         # A modern replacement for ls
      fd          # A modern replacement for find
      fzf         # A command-line fuzzy finder
      git         # Git
      jq          # jq is a lightweight and flexible command-line JSON processor
      lsof        # List open files
      nixd        # Nix development tool
      nil         # Nix Language Server
      unzip       # Unzip
      wget        # Wget
      vim         # Vim
    ];
  };
}