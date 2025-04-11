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
  neovim_cfg = config.solaaradotnet.editors.neovim;
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

    programs.neovide = mkIf neovim_cfg.enable {
      enable = true;
      settings = {
        font = {
          normal = "DejaVuSansM Nerd Font";
          size = 14.0;
        };
        tabs = false;
      };
    };
  };
}
