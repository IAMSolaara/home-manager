# vim:ts=2:sw=2:expandtab
{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  inherit (lib) mkIf mkMerge mkEnableOption mkOption mkDefault types getExe;
  cfg = config.solaaradotnet.pkgsets.kubetools;
  nushell_cfg = config.solaaradotnet.shells.nushell;
in {
  imports = [
    ./kubecolor.nix
    inputs.krewfile.homeManagerModules.krewfile
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
      [
        pkgs.kubectl
        pkgs.kns
        (pkgs.writeShellScriptBin
          "kubectl-virt"
          "${getExe pkgs.kubevirt} $@")
        pkgs.kustomize
        pkgs.kubernetes-helm
        pkgs.kubernetes-helmPlugins.helm-diff
        pkgs.kubernetes-helmPlugins.helm-git
        pkgs.kubernetes-helmPlugins.helm-s3
      ]
      # Full set
      (mkIf (cfg.flavor
        == "full") [
        pkgs.cilium-cli
        pkgs.talosctl
        pkgs.fluxcd
        pkgs.kubectl-cnpg

        # kubevirt and kubectl plugin
        pkgs.kubevirt
        (pkgs.writeShellScriptBin
          "kubectl-ns"
          "${pkgs.kns}/bin/kns $@")
      ])
    ];

    programs.k9s.enable = mkIf (cfg.flavor == "full") true;

    programs.krewfile = mkIf (cfg.flavor == "full") {
      enable = true;
      plugins = [
        "get-all"
        "rook-ceph"
      ];
    };

    programs.nushell.shellAliases = mkIf (nushell_cfg.enable) {
      k = mkDefault "kubectl";
    };
  };
}
