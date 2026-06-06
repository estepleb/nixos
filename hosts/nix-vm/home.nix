{ inputs, self, ... }:
{
  flake.nixosModules.nix-vm-home =
    { pkgs, ... }:
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ];

      home-manager.users.${self.username} = {
        home = {
          homeDirectory = self.homeDir;
          packages = with pkgs; [
            # Dev
            go
            nodejs
            python3
            just
            pnpm
            wireguard-tools
            duckdb
            # Utils
            optipng

            chezmoi
            opencode
          ];
          stateVersion = "25.11";
        };

        programs.home-manager.enable = true;
      };
    };
}
