{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.solaaradotnet.pkgsets.kubetools;
in {
  options = {
    solaaradotnet.pkgsets.kubetools = {
      enable = lib.mkEnableOption "enable kubetools pkgset.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      # k8s tools
      pkgs.kubectl
      pkgs.kubectx
      pkgs.kustomize
      pkgs.krew
      pkgs.k9s
      pkgs.kubernetes-helm
      pkgs.cilium-cli
      pkgs.talosctl
      pkgs.kubevirt
    ];

    programs.kubecolor = import ./kubecolor.nix;
  };
}
