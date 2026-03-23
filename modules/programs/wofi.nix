{
  flake.nixosModules.wofi = { pkgs, ... }:
  {
    home-manager.users.matthew.imports = [
    {
      programs.wofi = {
        enable = true;
      };
    }
    ];
  };
}
