# vim:ts=2:sw=2:expandtab
{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./modules
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "evermore";
  home.homeDirectory =
    if pkgs.stdenv.isDarwin
    then "/Users/evermore"
    else "/home/evermore";

  home.shell.enableShellIntegration = true;
  home.shell.enableZshIntegration = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.shellAliases = lib.mkMerge [
    {
      l = "ls -la";
      ll = "ls -l";
      vim = "nvim";
    }
    (lib.mkIf pkgs.stdenv.isDarwin {
      tailscale = "/Applications/Tailscale.app/Contents/MacOS/Tailscale";
      wireshark = "/Applications/Wireshark.app/Contents/MacOS/Wireshark";
    })
  ];
  home.sessionPath = [
    "/run/current-system/sw/bin"
    "/opt/homebrew/bin/"
    "/usr/local/bin"
    "~/.local/bin"
    "~/.cargo/bin"
    "/opt/homebrew/opt/mysql-client@5.7/bin"
    "/opt/homebrew/opt/mysql-client/bin"
    "~/.krew/bin"
    "~/.mix/escripts"
    "~/.bun/bin"
    "~/go/bin"
  ];

  solaaradotnet.shells.nushell.enable = true;
  solaaradotnet.editors.neovim.enable = true;
  solaaradotnet.pkgsets.kubetools.enable = true;
  solaaradotnet.pkgsets.kubetools.flavor = "full";
  solaaradotnet.pkgsets.guipkgs.enable = true;
  solaaradotnet.pkgsets.development.enable = true;

  home.packages = lib.mkMerge [
    # Universal packages
    [
      # misc tools
      pkgs.ncdu
      pkgs.minicom
      pkgs.rsgain
      pkgs.typst

      # fonts
      pkgs.nerd-fonts.dejavu-sans-mono
      pkgs.raleway
    ]
  ];

  fonts.fontconfig.enable = true;

  # --- DO NOT TOCH ---
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
}
