{ self, inputs, ... }:
{
  flake.nixosConfigurations.thinkbook-plus = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.thinkbook-plus-hardware

      self.nixosModules.audio
      self.nixosModules.bluetooth
      self.nixosModules.fonts
      self.nixosModules.home-manager
      self.nixosModules.nix
      self.nixosModules.dms
      self.nixosModules.dms-greeter
      self.nixosModules.limine
      self.nixosModules.users
      self.nixosModules.utils
      self.nixosModules.tailscale
      self.nixosModules.niri
      self.nixosModules.mango
      self.nixosModules.docker
      self.nixosModules.variables
      self.nixosModules."cachyos-kernel"

      # Base system
      self.nixosModules.base

      # Import hardware-specific configuration
      (
        {
          config,
          lib,
          pkgs,
          ...
        }:
        {
          nixpkgs.overlays = [
            inputs.mac-style-plymouth.overlays.default
          ];
          _module.args = {
            inherit inputs;
            nixpkgs-stable = inputs.nixpkgs-stable;
          };
        }
      )

      # Home Manager integration
      inputs.home-manager.nixosModules.home-manager
      inputs.stylix.nixosModules.stylix
      inputs.mango.nixosModules.mango
    ];
  };
}
