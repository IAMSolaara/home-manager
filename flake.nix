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
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    flake-utils,
    home-manager,
    bash-env-nushell,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages.homeConfigurations."evermore" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
            ./modules
          ];
          extraSpecialArgs = {
            inherit inputs;
            inherit system;
          };
        };
      }
    );
}
