{
  pkgs,
  config,
  lib,
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
  };
}
