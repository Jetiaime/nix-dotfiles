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
    
    # 添加 flake-utils 简化多系统支持
    flake-utils.url = "github:numtide/flake-utils";
    
    ###################################################
    #               External Tool Inputs             #
    ###################################################

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
  
  outputs = inputs@{ self, nixpkgs, darwin, home-manager, nix-homebrew, homebrew-core, homebrew-cask, flake-utils, ... }:
    let 
      user = "liu";
      darwinSystems = [ "aarch64-darwin" ];
    in {
      # Darwin 系统配置
      darwinConfigurations = nixpkgs.lib.genAttrs darwinSystems (system:
        darwin.lib.darwinSystem {
          inherit system;
          specialArgs = inputs // { inherit user; };
          modules = [
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
            {
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
        }
      ) // {
        "Blaze" = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = inputs // { inherit user; };
          modules = [
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
            {
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
      };
    };
}
