{ self, ... }:
{
  flake.nixosModules.niri = { pkgs, lib, config, ... }:
  {
    imports = [
      self.nixosModules.kitty
      self.nixosModules.matugen
      self.nixosModules.waybar
    ];

    programs.niri.enable = true;

    services.displayManager.ly = 
    let
      xsession-wrapper = pkgs.runCommand "xsession-wrapper-fixed" {
        src = config.services.displayManager.sessionData.wrapper;
      } ''
        cp --preserve=mode $src $out
        substituteInPlace $out --replace "X-NIXOS-SYSTEMD-AWARE" "X-NIXOS-SYSTEMD-AWARE|niri"
      '';
    in {
      enable = true;
      x11Support = false;
      settings = {
        setup_cmd = "${xsession-wrapper}";
        session_log = ".ly-session.log";
      };
    };

    services.udisks2.enable = true; # Removable media.
    services.gvfs.enable = true; # Nautilus mount and trash support.

    environment.systemPackages = with pkgs; [
      brightnessctl
      btop
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
      wl-clipboard
      wlsunset
      xwayland-satellite
    ];

    home-manager.users.${self.user}.imports = [
    {
      home.activation = {
        pywal = ''
          ${pkgs.pywal}/bin/wal --cols16 -i ${self.wallpaper}
        '';
        swaybg = ''
          ${pkgs.swaybg}/bin/swaybg -i ${self.wallpaper} &
        '';
        waybar = ''
          ${pkgs.procps}/bin/pkill -SIGUSR2 waybar
        '';
      };

      programs.rofi = {
        enable = true;
        font = "${self.font.mono} 18";
        extraConfig = {
          kb-row-up = "Up,Control+k,Shift+Tab,Shift+ISO_Left_Tab";
          kb-row-down = "Down,Control+j";
          kb-accept-entry = "Control+m,Return,KP_Enter";
          kb-remove-to-eol = "Control+Shift+e";
          kb-mode-next = "Shift+Right,Control+Tab,Control+l";
          kb-mode-previous = "Shift+Left,Control+Shift+Tab,Control+h";
          kb-mode-complete = "";
          kb-remove-char-back = "BackSpace";
        };
        theme = "~/.cache/wal/colors-rofi-dark.rasi";
      };

      services.dunst = {
        enable = true;
        settings = {
          global = {
            font = "${self.font.mono} 13";
            corner_radius = self.border.small;
          };
        };
      };

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
        spawn-sh-at-startup "swaybg -i ${self.wallpaper}" // Wallpaper utility.
        window-rule {
            geometry-corner-radius ${self.border.main}
        }
      '';

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
        gtk4.theme = null;
        theme = {
          name = "adw-gtk3-dark";
          package = pkgs.adw-gtk3;
        };
        cursorTheme = {
          name = "Bibata-Modern-Classic";
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
    }
    ];
  };
}
