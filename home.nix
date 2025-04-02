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

  programs.git.enable = true;
  programs.git.userName = "Sarah Evermore";
  programs.git.userEmail = "sarah.evermore.02@gmail.com";
  programs.git.signing.key = "~/.ssh/gitkey.pub";
  programs.git.signing.format = "ssh";
  programs.git.signing.signByDefault = true;
  programs.git.extraConfig = {
    init = {
      defaultbranch = "master";
    };
    push = {
      autosetupremote = true;
    };
  };
  programs.git.aliases = {
    lg = "lg1";
    lg1 = "lg1-specific --all";
    lg2 = "lg2-specific --all";
    lg3 = "lg3-specific --all";
    lg1-specific = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'";
    lg2-specific = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
    lg3-specific = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(auto)%d%C(reset)%n''          %C(white)%s%C(reset)%n''          %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)'";
  };
  programs.git.includes = [
    {
      path = "~/Workspace/Code/energit/.gitconfig";
      condition = "gitdir:~/Workspace/Code/energit/**";
    }
    {
      path = "~/Workspace/Code/energit/.gitconfig";
      condition = "gitdir:~/Workspace/Docs/energit/**";
    }
  ];

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
