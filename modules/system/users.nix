{ self, ... }: {
  flake.nixosModules.users = 
  # Users configuration for NixOS
  {
    config,
    pkgs,
    ...
  }: let
    username = self.username;
  in {
    users = {
      defaultUserShell = pkgs.bash;
  
      users.${username} = {
        isNormalUser = true;
        description = "${username} account";
        extraGroups = ["networkmanager" "wheel"];
      };
    };
  };
}
