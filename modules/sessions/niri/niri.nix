{ self, ... }:
{
  flake.nixosModules.niri =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      imports = [
        self.nixosModules.dolphin
        self.nixosModules.labwc
        self.nixosModules.ly
        self.nixosModules.matugen
        self.nixosModules.noctalia
        self.nixosModules.pywal
        self.nixosModules.theming
      ];

      kitty.wal.enable = true;

      programs.niri.enable = true;

      services.udisks2.enable = true; # Removable media.
      services.gvfs.enable = true; # Nautilus mount and trash support.

      environment.systemPackages = with pkgs; [
        brightnessctl
        btop
        eog
        gnome-themes-extra
        kdePackages.breeze
        kdePackages.breeze-icons
        kdePackages.kcalc
        mpv
        nautilus
        wl-clipboard
        xwayland-satellite
      ];

      home-manager.users.${self.username} =
        { config, ... }:
        {

          services.polkit-gnome.enable = true; # Enable Gnome polkit.
          systemd.user.services.polkit-gnome = {
            Service = {
              Restart = "on-failure";
              RestartSec = 1;
            };
            Unit = {
              StartLimitIntervalSec = 30;
              StartLimitBurst = 10;
            };
          };

          # Symlink config file.
          xdg.configFile."niri/config.kdl".source = ./config.kdl;

          # Write custom config file.
          xdg.configFile."niri/config-nix.kdl".text = /* kdl */ ''
            window-rule {
                geometry-corner-radius ${self.border.main}
            }
          '';

          # Set default applications.
          xdg.mimeApps = {
            enable = true;
            defaultApplications =
              let
                imageViewer = "org.gnome.eog.desktop";
                documentViewer = "org.kde.okular.desktop";
                videoViewer = "mpv.desktop";
              in
              {
                "image/png" = imageViewer;
                "image/jpg" = imageViewer;
                "image/jpeg" = imageViewer;
                "document/pdf" = documentViewer;
                "video/mp4" = videoViewer;
                "video/webm" = videoViewer;
              };
          };
        };
    };
}
