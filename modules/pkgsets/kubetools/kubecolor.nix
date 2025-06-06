# vim:ts=2:sw=2:expandtab
{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.solaaradotnet.pkgsets.kubetools;
  nushell_cfg = config.solaaradotnet.shells.nushell;
in {
  config = mkIf cfg.enable {
    programs.kubecolor.enable = true;
    programs.kubecolor.enableAlias = true;

    programs.nushell.shellAliases = mkIf (nushell_cfg.enable) {
      k = "kubecolor";
    };

    programs.kubecolor.settings = {
      preset = "dark";
      theme = {
        base = {
          info = "fg=#cad3f5";
          primary = "fg=#c6a0f6";
          secondary = "fg=#91d7e3";
          success = "fg=#a6da95:bold";
          warning = "fg=#eed49f:bold";
          danger = "fg=#ed8796:bold";
          muted = "fg=#8087a2";
          key = "fg=#b7bdf8:bold";
        };
        default = "fg=#cad3f5";
        data = {
          key = "fg=#b7bdf8:bold";
          string = "fg=#cad3f5";
          true = "fg=#a6da95:bold";
          false = "fg=#ed8796:bold";
          number = "fg=#c6a0f6";
          null = "fg=#8087a2";
          quantity = "fg=#c6a0f6";
          duration = "fg=#f5a97f";
          durationfresh = "fg=#a6da95";
          ratio = {
            zero = "fg=#8087a2";
            equal = "fg=#a6da95";
            unequal = "fg=#eed49f";
          };
        };
        status = {
          success = "fg=#a6da95:bold";
          warning = "fg=#eed49f:bold";
          error = "fg=#ed8796:bold";
        };
        table = {
          header = "fg=#cad3f5:bold";
          columns = "fg=#cad3f5";
        };
        stderr = {
          default = "fg=#cad3f5";
          error = "fg=#ed8796:bold";
        };
        describe = {key = "fg=#b7bdf8:bold";};
        apply = {
          created = "fg=#a6da95";
          configured = "fg=#eed49f";
          unchanged = "fg=#cad3f5";
          dryrun = "fg=#91d7e3";
          fallback = "fg=#cad3f5";
        };
        explain = {
          key = "fg=#b7bdf8:bold";
          required = "fg=#24273a:bold";
        };
        options = {flag = "fg=#b7bdf8:bold";};
        version = {key = "fg=#b7bdf8:bold";};
      };
    };
  };
}
