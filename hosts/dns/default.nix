{ self, inputs, ... }: {
  flake.nixosConfigurations.dns = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.dns-hardware
      
      # Boot
      self.nixosModules."grub-vm"
      
      # System modules
      self.nixosModules.home-manager
      self.nixosModules.nix
      self.nixosModules.users
      self.nixosModules.utils
      self.nixosModules.tailscale
      self.nixosModules.variables

      # Server modules
      self.nixosModules.ssh
      self.nixosModules.firewall
      self.nixosModules."caddy-tailscale"
      
      # Base system
      self.nixosModules.base
      
      # Import hardware-specific configuration  
      ({ config, lib, pkgs, ... }: {
        _module.args = {inherit inputs;};
      })
    ];
  };
}