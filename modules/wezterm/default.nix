# vim:ts=2:sw=2:expandtab
{
  pkgs,
  lib,
  ...
}: {
  programs.wezterm.enable = true;
  xdg.configFile."wezterm" = {
    enable = true;
    source = ./legacy-dotfiles;
  };
}
