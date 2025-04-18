# vim:ts=2:sw=2:expandtab
{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.solaaradotnet.pkgsets.guipkgs;
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
