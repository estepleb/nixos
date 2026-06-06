{ inputs, self, ... }:
{
  flake.nixosModules.nix-vm-home = { pkgs, ... }:{
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    home = {
      inherit self;
      homeDirectory = self.homeDir;

      packages = with pkgs; [
        # Dev
        go
        nodejs
        python3
        jq
        just
        pnpm
        wireguard-tools
        duckdb

        # Utils
        zip
        unzip
        optipng
        pfetch
        btop
        fastfetch
        tailscale
      ];

      # Don't touch this
      stateVersion = "25.11";
    };

    programs.home-manager.enable = true;
    };
}
