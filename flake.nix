# vim:ts=2:sw=2:expandtab
{
  description = "Home Manager configuration of evermore";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://solaaradotnet.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "solaaradotnet.cachix.org-1:ySwixOoVu7Fy9DggLJDza0u6JsvfQ9Gn4WVcTYOLxes="
    ];
  };

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nix-std.url = "github:chessai/nix-std";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    df-wezterm = {
      url = "github:iamsolaara/dotfilesWEZTERM";
      flake = false;
    };

    df-neovim = {
      url = "github:iamsolaara/dotfilesNVIM/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    flake-utils,
    home-manager,
    nix-std,
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
          ];
          extraSpecialArgs = {
            inherit inputs;
            inherit system;
            std = nix-std.lib;
            utils = import ./utils.nix {};
            flake_root = ./.;
            flake_res_path = ./res;
          };
        };
      }
    );
}
