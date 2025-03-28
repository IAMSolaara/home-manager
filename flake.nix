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
  }: {
    homeConfigurations."evermore@macos" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."aarch64-darwin";

      modules = [
        ./home.nix
        ./darwin.nix
      ];

      extraSpecialArgs = {
        inherit inputs;
        system = "aarch64-darwin";
      };
    };
    homeConfigurations."evermore@linux_arm" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."aarch64-linux";

      modules = [
        ./home.nix
        ./linux.nix
      ];

      extraSpecialArgs = {
        inherit inputs;
        system = "aarch64-linux";
      };
    };
    homeConfigurations."evermore@linux_x86" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."x86_64-linux";

      modules = [
        ./home.nix
        ./linux.nix
      ];

      extraSpecialArgs = {
        inherit inputs;
        system = "x86_64-linux";
      };
    };
  };
}
