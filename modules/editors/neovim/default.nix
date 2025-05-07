{
  lib,
  config,
  inputs,
  system,
  ...
}: let
  inherit (lib) mkIf getExe;

  cfg = config.solaaradotnet.editors.neovim;
  nushell_cfg = config.solaaradotnet.shells.nushell;

  are_guipkgs_enabled = config.solaaradotnet.pkgsets.guipkgs.enable;
in {
  options = {
    solaaradotnet.editors.neovim = {
      enable = lib.mkEnableOption "enable neovim.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [inputs.df-neovim.packages.${system}.default];
    programs.nushell.shellAliases = mkIf (nushell_cfg.enable) {
      so-nvim = getExe inputs.df-neovim.packages.${system}.default;
    };

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
