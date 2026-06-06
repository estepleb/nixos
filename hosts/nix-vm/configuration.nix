{ self, inputs, ... }: {
  flake.nixosConfigurations.nix-vm = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.nix-vm-hardware
      self.nixosModules.nix-vm-secrets
      
      # Boot
      self.nixosModules."grub-vm"
      self.nixosModules."mac-style-plymouth"
      
      # System modules
      self.nixosModules.home-manager
      self.nixosModules.nix
      self.nixosModules.users
      self.nixosModules.utils
      self.nixosModules.docker
      self.nixosModules.tailscale
      self.nixosModules."vm-guest"
      self.nixosModules."oci-containers"
      self.nixosModules."cachyos-kernel"

      # Server modules
      self.nixosModules.ssh
      self.nixosModules.firewall
      self.nixosModules."caddy-tailscale"
      self.nixosModules.opencloud
      self.nixosModules.syncthing
      self.nixosModules.ollama
      self.nixosModules."homepage-dashboard"
      self.nixosModules.paperless-ngx
      self.nixosModules."docling-serve"
      self.nixosModules."filebrowser-quantum"
      
      # Import hardware-specific configuration  
      ({ config, lib, pkgs, ... }: {
        _module.args = {inherit self inputs;};
        # Don't touch this
        system.stateVersion = "25.11";
      })
      
      # Additional packages
      ({ config, pkgs, ... }: {
        environment.systemPackages = with pkgs; [
          wget
          curl
          git
          chezmoi
          fish
          zoxide
          eza 
          bat
          fzf
          micro
          btrfs-progs
          fastfetch
          nix-search-cli
          openssl
          nh
          psmisc
          opencode
        ];
        
        nixpkgs.overlays = [ ];
      })
      
      # SOPS-Nix integration
      inputs.sops-nix.nixosModules.sops
    ];
    
  };
}
