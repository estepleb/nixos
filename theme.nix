{ self, ... }:
let
  wallpaper = "/home/${self.username}/Pictures/Wallpapers/";

  font = {
    mono = "JetBrainsMonoNerdFontMono";
    propo = "JetBrainsMonoNerdFontPropo";
    # mono = "IBM Plex Mono";
    # propo = "IBM Plex Mono";
  };

  border = {
    main = "12";
    small = "8";
  };
in
{
  flake = {
    inherit font;
    inherit wallpaper;
    inherit border;
  };
  flake.nixosModules.theming =
    { pkgs, ... }:
    {
      home-manager.users.${self.username} = {
        # Set cursor theme.
        home.file.".icons/default".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic";

        # Set dark theme for GTK programs.
        dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

        # Set GTK theme.
        gtk = {
          enable = true;
          gtk4.theme = null;
          theme = {
            name = "adw-gtk3-dark";
            package = pkgs.adw-gtk3;
          };
          cursorTheme = {
            name = "Bibata-Modern-Ice";
            package = pkgs.bibata-cursors;
            size = 24;
          };
          font = {
            name = "${self.font.mono}";
            size = 13;
          };
        };

        # Make QT follow GTK theme.
        qt = {
          enable = true;
          platformTheme.name = "gtk3";

          qt5ctSettings = {
            Fonts = {
              fixed = "\"${self.font.mono},13\"";
              general = "\"${self.font.mono},13\"";
            };
          };

          qt6ctSettings = {
            Fonts = {
              fixed = "\"${self.font.mono},13\"";
              general = "\"${self.font.mono},13\"";
            };
          };
        };
      };
    };
}
