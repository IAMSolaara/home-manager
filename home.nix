{
  pkgs,
  system,
  inputs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "evermore";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = [
    # desktop apps
    pkgs.feishin
    pkgs.virt-manager
    pkgs.imhex

    # k8s tools
    pkgs.kubectl
    pkgs.kubecolor
    pkgs.kubectx
    pkgs.kustomize
    pkgs.krew
    pkgs.k9s
    pkgs.kubernetes-helm
    pkgs.cilium-cli
    pkgs.talosctl
    pkgs.kubevirt

    # terminal stuff
    pkgs.wezterm
    pkgs.oh-my-posh
    inputs.bash-env-json.packages.${system}.default
    inputs.bash-env-nushell.packages.${system}.default

    # misc tools
    pkgs.ncdu
    pkgs.minicom

    # dev
    pkgs.git
    pkgs.github-cli
    pkgs.lazygit
    pkgs.go
    pkgs.maven
    pkgs.quarkus
    pkgs.go-task
    inputs.alejandra.defaultPackage.${system}
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
