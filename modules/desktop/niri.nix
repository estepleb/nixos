{ self, inputs, ... }: {
  flake.nixosModules.niri = { config, lib, pkgs, ... }: {
    imports = [
      inputs.niri.nixosModules.niri
    ];

    programs.niri = {
      enable = true;
      package = inputs.niri.packages.${pkgs.system}.default;
    };

    # Add required graphics drivers
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    # Add user to required groups
    users.users.${self.username}.extraGroups = [ "video" "render" ];
  };
}
