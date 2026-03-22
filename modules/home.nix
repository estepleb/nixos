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

      users.matthew = {
        home.stateVersion = "25.11";
        programs.home-manager.enable = true;
      };
    };
  };
}
