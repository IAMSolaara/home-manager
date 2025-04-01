{
  pkgs,
  config,
  lib,
  inputs,
  system,
  ...
}: let
  cfg = config.solaaradotnet.shells.nushell;
in {
  options = {
    solaaradotnet.shells.nushell = {
      enable = lib.mkEnableOption "enable nushell.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nushell.enable = true;
    programs.nushell.configFile.source = ./config.nu;
    programs.nushell.envFile.source = ./env.nu;

    programs.carapace.enable = true;
    programs.carapace.enableNushellIntegration = true;

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
  };
}
