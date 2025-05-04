{pkgs, ...}: {
  programs.fastfetch.enable = true;
  programs.fastfetch.settings = {
    "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
    display = {
      color = {
        keys = "light_magenta";
        title = "light_blue";
        separator = "light_blue";
      };
    };
    modules = [
      "title"
      "separator"
      "os"
      "host"
      "kernel"
      "uptime"
      "packages"
      "shell"
      "display"
      "de"
      "wm"
      "wmtheme"
      "theme"
      "icons"
      "font"
      "cursor"
      "terminal"
      "terminalfont"
      "cpu"
      "gpu"
      "memory"
      "swap"
      "disk"
      "localip"
      "battery"
      "poweradapter"
      "locale"
      "break"
      "colors"
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
