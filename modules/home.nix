{ inputs, self, ... }:
{
  flake.nixosModules.home-manager = {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs self; };
      backupCommand = "rm";

      users.${self.user} = {
        home.stateVersion = "25.11";
        programs.home-manager.enable = true;
      };
    };
  };
}
