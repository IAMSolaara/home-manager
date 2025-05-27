{
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];
  sops = {
    defaultSopsFile = ./secrets/main.enc.yaml;
    age.sshKeyPaths = ["${config.home.homeDirectory}/.ssh/home-sshkey"];
    age.keyFile = "${config.home.homeDirectory}/.sops-nix-age-key.txt";
    age.generateKey = true;
    secrets = {
      test = {};
    };
  };
}
