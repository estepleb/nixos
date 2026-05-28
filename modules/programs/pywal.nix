{ self, ... }:
{
  flake.nixosModules.pywal = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ pywal ];
    home-manager.users.${self.user} = {
      home.activation.pywal = "${pkgs.pywal}/bin/wal --cols16 -i ${self.wallpaper}";
    };
  };
}
