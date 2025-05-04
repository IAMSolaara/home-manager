# vim:ts=2:sw=2:expandtab
{
  pkgs,
  config,
  lib,
  inputs,
  system,
  ...
}: let
  cfg = config.solaaradotnet.shells.nushell;
in {
  imports = [
    ./oh-my-posh.nix
  ];
  options = {
    solaaradotnet.shells.nushell = {
      enable = lib.mkEnableOption "enable nushell.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.bash-env-json
      inputs.bash-env-nushell.packages.${system}.default
      inputs.so-logo-ascii-generator.packages.${system}.default
    ];
    programs.nushell.enable = true;
    programs.nushell.configFile.source = ./sources/config.nu;
    programs.nushell.envFile.source = ./sources/env.nu;
    programs.nushell.settings = {
      show_banner = false;
      cursor_shape.emacs = "blink_line";
      cursor_shape.vi_insert = "block";
      cursor_shape.vi_normal = "underscore";
      use_kitty_protocol = true;
      hooks.env_change.PWD = [];
    };

    programs.nushell.environmentVariables = {
      EDITOR = "nvim";
      ENV_CONVERSIONS = {
        NIX_PROFILES = {
          from_string = lib.hm.nushell.mkNushellInline "{|s| $s | split row (char space) }";
          to_string = lib.hm.nushell.mkNushellInline "{|v| $v | str join (char space) }";
        };
        PATH = {
          from_string = lib.hm.nushell.mkNushellInline "{|s| $s | split row (char esep) }";
          to_string = lib.hm.nushell.mkNushellInline "{|v| $v | str join (char esep) }";
        };
      };
    };

    programs.nushell.shellAliases = lib.mkMerge [
      {
        l = "ls -la";
        ll = "ls -l";
        vim = "nvim";
        hyfetch = "hyfetch --ascii-file ~/Documents/solaara_logo.txt";
        clabverter = ''docker run --rm --platform linux/amd64 --user (id -u) -v $"(pwd):/clabernetes/work" ghcr.io/srl-labs/clabernetes/clabverter'';
      }
      (lib.mkIf pkgs.stdenv.isDarwin {
        tailscale = "/Applications/Tailscale.app/Contents/MacOS/Tailscale";
        wireshark = "/Applications/Wireshark.app/Contents/MacOS/Wireshark";
        make_xiv_fullscreen = "aerospace fullscreen --no-outer-gaps on --window-id (get_aerospace_windows --app-name 'FINAL FANTASY XIV' | get window_id | to text | str trim)";
      })
    ];

    programs.nushell.extraConfig = ''
         use ${inputs.bash-env-nushell.packages.${system}.default}/bash-env.nu

         source ${./sources/fnm.nu}

      try {
      	 bash-env /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh | load-env
      }


      # show console banner
      try {
       so-logo-ascii-generator $"(hostname -s)" -c
      }
    '';

    programs.carapace.enable = true;
    programs.carapace.enableNushellIntegration = true;
  };
}
