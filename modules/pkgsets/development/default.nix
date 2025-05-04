# vim:ts=2:sw=2:expandtab
{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkMerge mkEnableOption mkOption mkDefault types getExe;
  cfg = config.solaaradotnet.pkgsets.development;
  neovim_cfg = config.solaaradotnet.editors.neovim;
in {
  options = {
    solaaradotnet.pkgsets.development = {
      enable = mkEnableOption "enable development pkgset.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = lib.mkMerge [
      [
        pkgs.github-cli
        pkgs.lazygit
        pkgs.lazyjj
        pkgs.rustup
        pkgs.go
        pkgs.maven
        pkgs.quarkus
        pkgs.go-task
        pkgs.alejandra
        pkgs.nixd
      ]
    ];

    # --JUJUTSU
    programs.jujutsu.enable = true;
    programs.jujutsu.settings = {
      user = {
        name = "Solaara Evermore";
        email = "sarah.evermore.02@gmail.com";
      };
      ui = {
        diff-editor = mkIf neovim_cfg.enable ["nvim" "-c" "DiffEditor $left $right $output"];
      };
      signing = {
        behavior = "own";
        key = "~/.ssh/gitkey.pub";
        backend = "ssh";
        signByDefault = true;
      };
    };

    # --GIT
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
  };
}
