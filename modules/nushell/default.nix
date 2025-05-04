# vim:ts=2:sw=2:expandtab
{
  pkgs,
  config,
  lib,
  inputs,
  system,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.solaaradotnet.shells.nushell;
in {
  imports = [
    ./oh-my-posh.nix
  ];
  options = {
    solaaradotnet.shells.nushell = {
      enable = mkEnableOption "enable nushell.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.bash-env-json
      inputs.bash-env-nushell.packages.${system}.default
    ];
    programs.nushell.enable = true;
    programs.nushell.configFile.source = ./sources/config.nu;
    programs.nushell.envFile.source = ./sources/env.nu;
    programs.nushell.extraConfig = ''
         use ${inputs.bash-env-nushell.packages.${system}.default}/bash-env.nu

         source ${./sources/fnm.nu}

      try {
           bash-env /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh | load-env
      }

         $env.ENV_CONVERSIONS."NIX_PROFILES" = {
           from_string: { |s| $s | split row (char space) }
           to_string: { |v| $v |  str join (char space) }
         }
    '';

    programs.carapace.enable = true;
    programs.carapace.enableNushellIntegration = true;
  };
}
