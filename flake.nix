{
  description = "TeAmo's nix-darwin system flake";

  inputs = {

    ###################################################
    #                    Nix Inputs                   #
    ###################################################

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager.url = "github:nix-community/home-manager/master";

    ###################################################
    #               External Tool Inputs              #
    ###################################################

    nix-openclaw.url = "github:openclaw/nix-openclaw";

    openspec.url = "github:Fission-AI/OpenSpec";

    ###################################################
    #                 Homebrew Inputs                 #
    ###################################################

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    homebrew-core = {
      url = "github:Homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:Homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      darwin,
      home-manager,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      ...
    }:
    let
      user = "liu";
      # Common configuration for all darwin systems
      darwinSystemModule = {
        imports = [
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
          {
            nixpkgs.overlays = [ inputs.nix-openclaw.overlays.default ];
            nix-homebrew = {
              inherit user;
              enable = true;
              enableRosetta = true;
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
              };
              mutableTaps = false;
              autoMigrate = true;
            };
          }
          ./hosts/darwin
        ];
      };
      mkDarwinSystem = system:
        darwin.lib.darwinSystem {
          inherit system;
          specialArgs = inputs // {
            inherit user;
            inherit (inputs) nix-openclaw;
          };
        } // darwinSystemModule;
    in
    {
      # Darwin 系统配置 - consolidated
      darwinConfigurations = {
        "Blaze" = mkDarwinSystem "aarch64-darwin";
      };
    };
}
