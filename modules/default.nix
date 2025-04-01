# vim:ts=2:sw=2:expandtab
{
  pkgs,
  config,
  options,
  ...
}: {
  imports = [
    ./nushell
    ./kubetools
  ];
}
