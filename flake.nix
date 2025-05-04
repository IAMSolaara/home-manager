# vim:ts=2:sw=2:expandtab
{
  description = "Home Manager configuration of evermore";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bash-env-nushell = {
      url = "github:tesujimath/bash-env-nushell/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    krewfile = {
      url = "github:brumhard/krewfile";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    so-logo-ascii-generator = {
      url = "github:solaaradotnet/so-logo-ascii-generator";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    flake-utils,
    home-manager,
    bash-env-nushell,
    krewfile,
    so-logo-ascii-generator,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        home-nix = ./home.nix;
      in {
        packages.home-nix = {
          pkgs,
          lib,
          ...
        }:
          import ./home.nix {
            inherit inputs;
            inherit pkgs;
            inherit system;
            inherit lib;
          };

        packages.homeConfigurations."evermore" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            home-nix
          ];
          extraSpecialArgs = {
            inherit inputs;
            inherit system;
          };
        };
      }
    );
}
