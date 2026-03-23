{
  flake.nixosModules.kitty = {
    home-manager.users.matthew.imports = [
    {
      programs.kitty = {
        enable = true;
        font = {
          name = "JetBrainsMonoNerdFont";
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
