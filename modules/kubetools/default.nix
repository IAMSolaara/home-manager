{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.solaaradotnet.pkgsets.kubetools;
in {
  imports = [
    ./kubecolor.nix
  ];
  options = {
    solaaradotnet.pkgsets.kubetools = {
      enable = lib.mkEnableOption "enable kubetools pkgset.";
      flavor = lib.mkOption {
        type = lib.types.enum ["minimal" "full"];
        default = "full";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.mkMerge [
      (lib.mkIf (cfg.flavor
        == "full") [
        pkgs.cilium-cli
        pkgs.talosctl
        pkgs.kubevirt
      ])
      [
        pkgs.kubectl
        pkgs.kubectx
        pkgs.kustomize
        pkgs.krew
        pkgs.kubernetes-helm
      ]
    ];

    programs.k9s.enable = lib.mkIf (cfg.flavor == "full") true;
  };
}
