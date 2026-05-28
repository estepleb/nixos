{ self, ... }:
{
  flake.nixosModules.kitty = { config, lib, ... }: {
    options = {
      kitty.wal = {
        enable = lib.mkOption {
          default = false;
          type = lib.types.bool;
        };
      };
    };

    config = {
      home-manager.users.${self.user} = {
        programs.kitty = {
          enable = true;
          font = {
            name = "${self.font.mono}";
            size = 13;
          };
          settings = {
            confirm_os_window_close = 0;
            remember_window_size = "no";
            cursor_trail = 1;
          };
          extraConfig = lib.mkIf config.kitty.wal.enable ''
            include ~/.cache/wal/colors-kitty.conf
            background_opacity 0.85
          '';
          themeFile = lib.mkIf (!config.kitty.wal.enable) "Catppuccin-Mocha";
        };
      };
    };
  };
}
