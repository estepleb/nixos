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
      backupFileExtension = "hm-backup";
    };
  };
}
