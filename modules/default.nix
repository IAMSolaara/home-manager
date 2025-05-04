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
