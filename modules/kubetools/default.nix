# vim:ts=2:sw=2:expandtab
{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkMerge mkEnableOption mkOption types;
  cfg = config.solaaradotnet.pkgsets.kubetools;
  nushell_cfg = config.solaaradotnet.shells.nushell;
in {
  imports = [
    ./kubecolor.nix
  ];
  options = {
    solaaradotnet.pkgsets.kubetools = {
      enable = mkEnableOption "enable kubetools pkgset.";
      flavor = mkOption {
        type = types.enum ["minimal" "full"];
        default = "full";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = mkMerge [
      (mkIf (cfg.flavor
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

    programs.k9s.enable = mkIf (cfg.flavor == "full") true;

    home.shellAliases = mkIf (cfg.flavor == "full") {
      "kubectl-virt" = "virtctl";
    };
    programs.nushell.shellAliases = mkIf (cfg.flavor == "full" && nushell_cfg.enable) {
      "kubectl-virt" = "virtctl";
    };
  };
}
