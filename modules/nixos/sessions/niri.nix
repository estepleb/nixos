{ self, lib, ... }:
{
  flake.nixosModules.niri = { pkgs, ... }:
  {
    imports = [
      self.nixosModules.wofi 
      self.nixosModules.waybar
      self.nixosModules.matugen
    ];

    programs.niri.enable = true;
    services.displayManager.gdm.enable = true;

    services.udisks2.enable = true; # Removable media.
    services.gvfs.enable = true; # Nautilus mount and trash support.

    environment.systemPackages = with pkgs; [
      brightnessctl
      dunst
      eog
      gnome-themes-extra
      kdePackages.breeze
      kdePackages.dolphin
      kdePackages.kcalc
      mpv
      nautilus
      pywal
      swaybg
      waybar
      wlsunset
      xwayland-satellite
    ];

    home-manager.users.matthew.imports = [
    {
      services.polkit-gnome.enable = true; # Enable Gnome polkit.

      # Symlink config file.
      xdg.configFile."niri/config.kdl".source = ./config.kdl;

      # Set default applications.
      xdg.mimeApps = {
        enable = true;
        defaultApplications = let
          imageViewer = "org.gnome.eog.desktop";
          documentViewer = "org.kde.okular.desktop";
          videoViewer = "mpv.desktop";
        in {
          "image/png" = imageViewer;
          "image/jpg" = imageViewer;
          "image/jpeg" = imageViewer;
          "document/pdf" = documentViewer;
          "video/mp4" = videoViewer;
          "video/webm" = videoViewer;
        };
      };

      # Set cursor theme.
      home.file.".icons/default".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic";

      # Set dark theme for GTK programs.
      dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

      # Set GTK theme.
      gtk = {
        enable = true;
        theme = {
          name = "adw-gtk3-dark";
          package = pkgs.adw-gtk3;
        };
        cursorTheme = {
          name = "Bibata-Modern-Classic";
          package = pkgs.bibata-cursors;
          size = 24;
        };
      };

      # Make QT follow GTK theme.
      qt = {
        enable = true;
        platformTheme.name = "gtk3";
      };
    }
    ];
  };
}
