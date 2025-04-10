# vim:ts=2:sw=2:expandtab
{
  pkgs,
  lib,
  inputs,
  config,
  options,
  ...
}: let
  inherit (lib) mkIf mkMerge mkEnableOption mkOption mkDefault types getExe;
  cfg = config.solaaradotnet.pkgsets.guipkgs;
  nushell_cfg = config.solaaradotnet.shells.nushell;
in {
  options = {
    solaaradotnet.pkgsets.guipkgs = {
      enable = mkEnableOption "enable guipkgs pkgset.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = lib.mkMerge [
      [
        # all systems
        pkgs.feishin
        pkgs.virt-manager
        pkgs.imhex
      ]
      (
        lib.mkIf
        pkgs.stdenv.isDarwin
        [
          # macOS
          pkgs.raycast
          pkgs.alt-tab-macos
        ]
      )
    ];
    programs.wezterm.enable = true;
    xdg.configFile."wezterm" = {
      enable = true;
      source = inputs.df-wezterm;
    };
  };
}
