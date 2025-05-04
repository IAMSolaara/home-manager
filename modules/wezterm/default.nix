# vim:ts=2:sw=2:expandtab
{
  pkgs,
  lib,
  ...
}: {
  home.packages = [
    pkgs.wezterm
  ];
  #programs.wezterm.enable = true;
  #xdg.configFile."wezterm" = {
  #  enable = true;
  #  source = ./legacy-dotfiles;
  #};
}
