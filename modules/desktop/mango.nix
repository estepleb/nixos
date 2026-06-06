{ self, inputs, ... }: {
  flake.nixosModules.mango = { config, lib, pkgs, ... }: {
    imports = [
      inputs.mango.nixosModules.mango
    ];

    services.mango = {
      enable = true;
      user = self.username;
    };
  };
}
