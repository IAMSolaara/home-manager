{
  description = "Home Manager configuration of evermore";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/3.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bash-env-json = {
      url = "github:tesujimath/bash-env-json/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bash-env-nushell = {
      url = "github:tesujimath/bash-env-nushell/main";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.bash-env-json.follows = "bash-env-json";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    alejandra,
    bash-env-json,
    bash-env-nushell,
    ...
  }: let
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations."evermore" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = with pkgs.stdenv;
        if isDarwin
        then [
          ./home.nix
          ./darwin.nix
        ]
        else if isLinux
        then [
          ./home.nix
          #./linux.nix
        ]
        else [./home.nix];

      extraSpecialArgs = {
        inherit inputs;
        inherit system;
      };
    };
  };
}
