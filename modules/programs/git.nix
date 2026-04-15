{ self, ... }:
{
  flake.nixosModules.git = {
    home-manager.users.${self.user}.imports = [
    {
      programs.git = {
        enable = true;
        settings = {
          user = {
            name = "Senior Matt";
            email = "matthew.prakhov@gmail.com";
          };
          core = {
            editor = "nvim";
          };
        };
      };
    }
    ];
  };
}
