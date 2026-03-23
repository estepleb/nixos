{
  flake.nixosModules.matugen = { pkgs, lib, ... }:
  {
    home-manager.users.matthew.imports = [
    {
      home.packages = with pkgs; [ 
        matugen
        kdePackages.breeze
        kdePackages.qt6ct
        libsForQt5.qt5ct
      ];

      xdg.configFile = {
        "matugen/config.toml".text = /* toml */ ''
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
        '';
        "kdeglobals".text = ''
          [UiSettings]
          ColorScheme=Matugen
        '';
      };

      qt = {
        enable = true;
        platformTheme.name = lib.mkForce "qt6ct";

        qt5ctSettings = {
          Appearance = {
            color_scheme_path = "/home/matthew/.config/qt5ct/colors/matugen.conf";
            custom_palette = true;
          };
        };

        qt6ctSettings = {
          Appearance = {
            color_scheme_path = "/home/matthew/.config/qt5ct/colors/matugen.conf";
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
