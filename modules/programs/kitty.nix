{ self, ... }:
{
  flake.nixosModules.kitty = {
    home-manager.users.${self.user}.imports = [
    {
      programs.kitty = {
        enable = true;
        font = {
          name = "${self.font.mono}";
          size = 13;
        };
        settings = {
          confirm_os_window_close = 0;
        };
        extraConfig = ''
          include ~/.cache/wal/colors-kitty.conf
        '';
      };
    }
    ];
  };
}
