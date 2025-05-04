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
    flake-utils,
    home-manager,
    alejandra,
    bash-env-json,
    bash-env-nushell,
    ...
  }: {
    homeConfigurations = builtins.listToAttrs (map (system: {
        name = "evermore-${system}"; # You can name the configurations based on system and architecture
        value = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = with {
            isDarwin = nixpkgs.legacyPackages.${system}.stdenv.isDarwin;
            isLinux = nixpkgs.legacyPackages.${system}.stdenv.isLinux;
          };
            if isDarwin
            then [
              ./home.nix
              ./darwin.nix
            ]
            else if isLinux
            then [
              ./home.nix
              ./linux.nix
            ]
            else throw "Unsupported system";
          extraSpecialArgs = {
            inherit inputs;
            inherit system;
          };
        };
      })
      flake-utils.lib.defaultSystems);
    #homeConfigurations =
    #	flake-utils.lib.eachDefaultSystem (system:
    #		name = "evermore-${system}";
    #value = home-manager.lib.homeManagerConfiguration {
    #	pkgs = nixpkgs.legacyPackages.${system};
    #}
    #	);
    #homeConfigurations."evermore@macos" = home-manager.lib.homeManagerConfiguration {
    #  pkgs = nixpkgs.legacyPackages."aarch64-darwin";

    #  modules = [
    #    ./home.nix
    #    ./darwin.nix
    #  ];

    #  extraSpecialArgs = {
    #    inherit inputs;
    #    system = "aarch64-darwin";
    #  };
    #};
  };
}
