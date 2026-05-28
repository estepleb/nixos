{ self, ... }:
{
  flake.nixosModules.matugen = { pkgs, lib, ... }:
  let 
      # Building the latest matugen 4.1.0 for --opacity flag.
      matugen = pkgs.matugen.overrideAttrs (old: {
        version = "4.1.0";
        src = pkgs.fetchFromGitHub {
          owner = "InioX";
          repo = "matugen";
          rev = "v4.1.0";
          hash = "sha256-xzwMDWb6pF3oStVoS8enNhpYptxdnB1NSIO7dUH6/qk=";
        };
        cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
          inherit (old) pname;
          version = "4.1.0";
          src = pkgs.fetchFromGitHub {
            owner = "InioX";
            repo = "matugen";
            rev = "v4.1.0";
            hash = "sha256-xzwMDWb6pF3oStVoS8enNhpYptxdnB1NSIO7dUH6/qk=";
          };
          hash = "sha256-bfvlPiTlPQeedo+ikHXSI8NqdA5R5M7gCsgx7srYsMQ=";
        };
      });
  in{
    environment.systemPackages = [ matugen ];

    home-manager.users.${self.user}.imports = [
    {
      home.activation.matugen = "${matugen}/bin/matugen image ${self.wallpaper} --opacity 0.85 --source-color-index 0";
      
      home.packages = with pkgs; [
        kdePackages.breeze
        kdePackages.qt6ct
        killall
        libsForQt5.qt5ct
      ];

      xdg.configFile = {
        "matugen/config.toml" = {
          text = /* toml */ ''
            [config]
            [templates.gtk3]
            input_path = '${builtins.toString ./templates/gtk-colors.css}'
            output_path = '~/.config/gtk-3.0/colors.css'

            [templates.gtk4]
            input_path = '${builtins.toString ./templates/gtk-colors.css}'
            output_path = '~/.config/gtk-4.0/colors.css'

            [templates.color-scheme]
            input_path = '${builtins.toString ./templates/Matugen.colors}'
            output_path = '~/.local/share/color-schemes/Matugen.colors'

            [templates.qt5ct]
            input_path = '${builtins.toString ./templates/qtct-colors.conf}'
            output_path = '~/.config/qt5ct/colors/matugen.conf'

            [templates.qt6ct]
            input_path = '${builtins.toString ./templates/qtct-colors.conf}'
            output_path = '~/.config/qt6ct/colors/matugen.conf'

            [templates.kvantum_kvconfig]
            input_path = '${builtins.toString ./templates/kvantum-colors.kvconfig}'
            output_path = '~/.config/Kvantum/matugen/matugen.kvconfig'
            
            [templates.kvantum_svg]
            input_path = '${builtins.toString ./templates/kvantum-colors.svg}'
            output_path = '~/.config/Kvantum/matugen/matugen.svg'

            [templates.niri]
            input_path = '${builtins.toString ./templates/niri-colors.kdl}'
            output_path = '~/.config/niri/colors.kdl'

            [templates.waybar]
            input_path = '${builtins.toString ./templates/colors.css}'
            output_path = '~/.config/waybar/colors.css'
          '';
        };

        "kdeglobals".text = ''
          [UiSettings]
          ColorScheme=Matugen
        '';
        "Kvantum/kvantum.kvconfig".text = ''
          [General]
          theme=matugen
        '';
      };

      qt = {
        enable = true;
        platformTheme.name = lib.mkForce "qt6ct";
        style.name = lib.mkForce "kvantum";

        qt5ctSettings = {
          Appearance = {
            color_scheme_path = "/home/${self.user}/.config/qt5ct/colors/matugen.conf";
            custom_palette = true;
          };
        };

        qt6ctSettings = {
          Appearance = {
            color_scheme_path = "/home/${self.user}/.config/qt5ct/colors/matugen.conf";
            custom_palette = true;
          };
        };
      };

      gtk = {
        enable = true;
        gtk4.extraCss = "@import 'colors.css';";
        gtk3.extraCss = "@import 'colors.css';";
      };
    }
    ];
  };
}
