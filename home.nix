# vim:ts=2:sw=2:expandtab
{
  pkgs,
  lib,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "evermore";
  home.homeDirectory =
    if pkgs.stdenv.isDarwin
    then "/Users/evermore"
    else "/home/evermore";

  solaaradotnet.shells.nushell.enable = true;
  solaaradotnet.pkgsets.kubetools.enable = true;
  solaaradotnet.pkgsets.kubetools.flavor = "full";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = lib.mkMerge [
    # Universal packages
    [
      # desktop apps
      pkgs.feishin
      pkgs.virt-manager
      pkgs.imhex

      # terminal stuff
      pkgs.wezterm

      # misc tools
      pkgs.ncdu
      pkgs.minicom

      # dev
      pkgs.git
      pkgs.github-cli
      pkgs.lazygit
      pkgs.rustup
      pkgs.go
      pkgs.maven
      pkgs.quarkus
      pkgs.go-task
      pkgs.alejandra
      pkgs.php
    ]

    # macOS packages
    (
      lib.mkIf
      pkgs.stdenv.isDarwin
      [
        pkgs.raycast
        pkgs.alt-tab-macos
      ]
    )
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
