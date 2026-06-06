{ self, ... }:
{
  flake.nixosModules.docker =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      virtualisation.docker.enable = true;
      virtualisation.docker.rootless = {
        enable = true;
        setSocketVariable = true;
      };
      users.users.${self.username}.extraGroups = [ "docker" ];
    };
}
