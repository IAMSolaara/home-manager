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

  home.packages = lib.mkMerge [
    # Universal packages
    [
      # misc tools
      pkgs.ncdu
      pkgs.minicom
      pkgs.rsgain

      # dev
      pkgs.github-cli
      pkgs.lazygit
      pkgs.rustup
      pkgs.go
      pkgs.maven
      pkgs.quarkus
      pkgs.go-task
      pkgs.alejandra
      pkgs.nixd

      # fonts
      pkgs.nerd-fonts.dejavu-sans-mono
      pkgs.raleway
    ]
  ];

  fonts.fontconfig.enable = true;

  programs.jujutsu.enable = true;
  programs.jujutsu.settings = {
    user = {
      name = "Solaara Evermore";
      email = "sarah.evermore.02@gmail.com";
    };
  };
  programs.git = {
    enable = true;
    userName = "Solaara Evermore";
    userEmail = "sarah.evermore.02@gmail.com";
    signing.key = "~/.ssh/gitkey.pub";
    signing.format = "ssh";
    signing.signByDefault = true;
    extraConfig = {
      init = {
        defaultbranch = "master";
      };
      push = {
        autosetupremote = true;
      };
    };
    aliases = {
      lg = "lg1";
      lg1 = "lg1-specific --all";
      lg2 = "lg2-specific --all";
      lg3 = "lg3-specific --all";
      lg1-specific = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'";
      lg2-specific = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
      lg3-specific = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(auto)%d%C(reset)%n''          %C(white)%s%C(reset)%n''          %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)'";
    };
    includes = [
      {
        path = "~/Workspace/Code/energit/.gitconfig";
        condition = "gitdir:~/Workspace/Code/energit/**";
      }
      {
        path = "~/Workspace/Code/energit/.gitconfig";
        condition = "gitdir:~/Workspace/Docs/energit/**";
      }
    ];
  };

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
