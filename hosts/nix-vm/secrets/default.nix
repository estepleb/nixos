{ self, ... }:
{
  flake.nixosModules.nix-vm-secrets =
    { pkgs, config, ... }:
    {
      sops = {
        age.keyFile = "/home/${self.username}/.config/sops/age/keys.txt";
        defaultSopsFile = ./secrets.yaml;
        validateSopsFiles = true;
        secrets = {
          # sshconfig = {
          #   owner = self.username;
          #   path = "/home/${self.username}/.ssh/config";
          #   mode = "0600";
          #   };
          # github-key = {
          #   owner = self.username;
          #   path = "/home/${self.username}/.ssh/github";
          #   mode = "0600";
          # };
          # signing-key = {
          #   owner = self.username;
          #   path = "/home/${self.username}/.ssh/key";
          #   mode = "0600";
          # };
          # signing-pub-key = {
          #   owner = self.username;
          #   path = "/home/${self.username}/.ssh/key.pub";
          #   mode = "0600";
          # };
        };
      };
      environment.systemPackages = with pkgs; [
        sops
        age
      ];
    };
}
