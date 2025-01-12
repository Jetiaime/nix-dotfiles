{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.${namespace}.programs.cli;
in {
  imports = [ (lib.snowfall.fs.get-file "modules/common/programs/cli/default.nix") ];

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bash-completion
      cask         # unknown package
      gawk         # GNU awk
      gnused       # GNU sed
      gnugrep      # GNU grep
      gnupg        # GNU Privacy Guard
      gnutls       # GNU Transport Layer Security Library
      mas          # Mac App Store CLI
    ];
  };
}