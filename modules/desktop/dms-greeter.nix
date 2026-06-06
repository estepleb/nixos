{ inputs, ... }:
{
  flake.nixosModules."dms-greeter" =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.dms.nixosModules.greeter
      ];

      services.dms-greeter = {
        enable = true;
        user = config.var.username;
      };
    };
}
