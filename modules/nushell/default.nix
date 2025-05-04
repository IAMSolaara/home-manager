{
  pkgs,
  config,
}: {
  programs.nushell.enable = true;
  programs.nushell.configFile.source = ./config.nu;
  programs.nushell.envFile.source = ./env.nu;

  programs.carapace.enable = true;
  programs.carapace.enableNushellIntegration = true;
}
