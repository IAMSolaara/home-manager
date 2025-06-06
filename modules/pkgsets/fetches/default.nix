{
  lib,
  std,
  flake_res_path,
  config,
  utils,
  ...
}: let
  inherit (utils) make_rgb_esc_fg;
  # make_key
  make_key = key: (make_rgb_esc_fg 255 241 164) + std.string.justifyRight 10 " " key;

  are_guipkgs_enabled = config.solaaradotnet.pkgsets.guipkgs.enable;
in {
  programs.fastfetch.enable = true;
  programs.fastfetch.settings = {
    "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
    logo = lib.mkIf are_guipkgs_enabled {
      type = "iterm";
      source = flake_res_path + /solaara_logo_flat.png;
      width = 30;
      padding = {
        left = 4;
        top = 2;
      };
    };
    display = {
      color = {
        keys = "bright_yellow";
        title = "bright_yellow";
        separator = "bright_yellow";
      };
      key = {
        width = 13;
      };
      # 51, 46%, 37%
      separator = (make_rgb_esc_fg 171 155 63) + "│";
      constants = [
        # solaara gold color ESC sequence
        (
          make_rgb_esc_fg
          255
          241
          164
        )
      ];
    };
    modules = [
      {type = "break";}
      {type = "break";}
      {
        type = "os";
        key = make_key "OS";
      }
      {
        type = "host";
        key = make_key "Host";
      }
      {
        type = "title";
        key = make_key "FQDN";
        fqdn = true;
        format = "{host-name}";
      }
      {
        type = "kernel";
        key = make_key "Kernel";
      }
      {
        type = "uptime";
        key = make_key "Uptime";
      }
      {
        type = "packages";
        key = make_key "Packages";
      }
      {
        type = "shell";
        key = make_key "Shell";
      }
      {
        type = "de";
        key = make_key "DE";
      }
      {
        type = "wm";
        key = make_key "WM";
      }
      {
        type = "wmtheme";
        key = make_key "Kernel";
      }
      {
        type = "theme";
        key = make_key "Theme";
      }
      {
        type = "icons";
        key = make_key "Icons";
      }
      {
        type = "terminal";
        key = make_key "Terminal";
      }
      {
        type = "cpu";
        key = make_key "CPU";
      }
      {
        type = "gpu";
        key = make_key "GPU";
      }
      {
        type = "memory";
        key = make_key "Memory";
      }
      {
        type = "disk";
        folders = ["/"];
        key = make_key "Disk (/)";
      }
      {
        type = "break";
      }
      # {
      #   type = "colors";
      # }
    ];
  };

  programs.hyfetch.enable = true;
  programs.hyfetch.settings = {
    preset = "transgender";
    mode = "rgb";
    light_dark = "dark";
    lightness = 0.65;
    color_align = {
      mode = "vertical";
      #custom_colors = ["#F6AAB7" "#F6AAB7" "#FFFFFF" "#55CDFD"];
    };
    backend = "fastfetch";
  };
}
