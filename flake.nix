{
  description = "TeAmo's Nix Darwin Configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    # Nixpkgs Unstable
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Nix-Darwin
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix-Homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Snowfall Lib
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Snowfall Flake
    snowfall-flake = {
      url = "github:snowfallorg/flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # WezTerm
    wezterm.url = "github:wez/wezterm?dir=nix";
  };

  outputs = {...} @ inputs:
  let
    inherit (inputs) snowfall-lib;

    lib = snowfall-lib.mkLib {
      inherit inputs;

      src = ./.;

      snowfall = {
        namespace = "teamo";
        meta = {
          name = "teamo";
          title = "TeAmo";
        };
      };
    };
  in lib.mkFlake {
    channels-config = {
      allowUnfree = true;
      permittedInsecurePackages = [];
      config = {};
    };

    overlays = [];

    systems = {};
  };
}
