{ self, inputs, ... }:
{
  flake.nixosModules.dms =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.dms.nixosModules.default
      ];

      services.dms = {
        enable = true;
        user = self.username;
      };
    };
}
