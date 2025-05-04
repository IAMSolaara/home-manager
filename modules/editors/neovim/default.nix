{
  lib,
  config,
  ...
}: let
  cfg = config.solaaradotnet.editors.neovim;

  are_guipkgs_enabled = config.solaaradotnet.pkgsets.guipkgs.enable;
in {
  options = {
    solaaradotnet.editors.neovim = {
      enable = lib.mkEnableOption "enable neovim.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.neovim.enable = true;

    programs.neovide = lib.mkIf are_guipkgs_enabled {
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
