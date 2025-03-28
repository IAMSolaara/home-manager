{
  pkgs,
  system,
  inputs,
  ...
}: let
  home_path = "/Users/evermore";
in {
  home.homeDirectory = home_path;

  home.packages = [
    pkgs.raycast
    pkgs.alt-tab-macos
  ];

  home.file."Library/Application Support/nushell/vendor/autoload/00-load-bash-env.nu" = {
    text = ''
      use ${inputs.bash-env-nushell.packages.${system}.default}/bash-env.nu
    '';
  };
  home.file."Library/Application Support/nushell/vendor/autoload/01-load-nix-env.nu" = {
    text = ''
      bash-env /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh | load-env
      path add /run/current-system/sw/bin

      $env.ENV_CONVERSIONS."NIX_PROFILES" = {
      	 from_string: { |s| $s | split row (char space) }
      	 to_string: { |v| $v |  str join (char space) }
      }
    '';
  };

  home.sessionVariables = {
    "HMS_PATH" = "${pkgs.home-manager}/bin/home-manager switch --flake ${home_path}/.config/home-manager#evermore-${system}";
  };
}
