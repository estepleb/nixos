{ self, ... }:
{
  flake.nixosModules.waybar = { pkgs, ... }:
  {
    environment.systemPackages = with pkgs; [
      bluetui
      wiremix
    ];

    fonts.packages = with pkgs; [
      font-awesome
    ];

    home-manager.users.${self.user}.imports = [
    {
      home.activation = {
        waybar = ''
          ${pkgs.procps}/bin/pkill -SIGUSR2 waybar
        '';
      };

      programs.waybar = {
        enable = true;
        settings = {
          bar = {
            height = 24;
            # width = 24;
            layer = "top";
            spacing = 0;
            position = "bottom";
            modules-left = [ "niri/workspaces" "niri/language" ];
            modules-center = [ "niri/window" ];
            modules-right = [ "tray" "wireplumber" "network" "bluetooth" "backlight" "clock" "battery" "battery#bat2" "custom/power" ];
            "niri/workspaces" = {
              "disable-scroll" = true;
              "all-outputs" = true;
              "warp-on-scroll" = false;
              "format" = "{icon}";
            };
            "tray" = {
                "spacing" = 10;
            };
            "niri/language" = {
                "format" = "{short}";
            };
            "clock" = {
                "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            };
            "backlight" = {
                "format" = "{icon} {percent}%";
                "format-icons" = ["" "" "" "" "" "" "" "" ""];
            };
            "battery" = {
                "bat" = "BAT0";
                "states" = {
                    "good" = 95;
                    "warning" = 30;
                    "critical" = 15;
                };
                "format" = "{icon} {capacity}%";
                "format-full" = "{icon} {capacity}%";
                "format-charging" = " {capacity}%";
                "format-icons" = ["" "" "" "" ""];
            };
            "battery#bat2" = {
                "bat" = "BAT1";
                "states" = {
                    "good" = 95;
                    "warning" = 30;
                    "critical" = 15;
                };
                "format" = "{icon} {capacity}%";
                "format-full" = "{icon} {capacity}%";
                "format-charging" = " {capacity}%";
                "format-plugged" = " {capacity}%";
                "format-icons" = ["" "" "" "" ""];
            };
            "bluetooth" = {
                "format" = "";
                "format-off" = "󰂲";
                "on-click" = "kitty --hold sh -c 'bluetui'";
            };
            "network" = {
                "format-wifi" = " {essid}";
                "format-disconnected" = "󰖪";
                "on-click" = "kitty --hold sh -c 'nmtui'";
            };
            "wireplumber" = {
                "format" = "{icon} {volume}%";
                "format-muted" = "󰖁";
                "format-icons" = {
                    "default" = ["" "" ""];
                };
                "on-click" = "kitty --hold sh -c 'wiremix'";
            };
            "custom/power" = {
                "format"  = "⏻";
                "on-click" = "systemctl suspend";
                # "shutdown" = "shutdown";
                # "reboot" = "reboot";
                # "suspend" = "systemctl suspend";
                # "hibernate" = "systemctl hibernate"
            };
          };
        };

        style = /*css*/ ''
          /* @import "/home/${self.user}/.cache/wal/colors-waybar.css"; */
          @import "/home/${self.user}/.config/waybar/colors.css";

          * {
              /* `otf-font-awesome` is required to be installed for icons */
              font-family: ${self.font.propo}, JetBrainsMonoNerdFontPropo;
              font-size: 13pt;
              transition-property: background-color;
              transition-duration: .25s;
          }

          window#waybar {
              background-color: @background;
              color: @on_surface;
          }

          button {
              /* Use box-shadow instead of border so the text isn't offset */
              box-shadow: inset 0 -3px transparent;
              /* Avoid rounded borders under each button name */

              border: none;
              border-radius: ${self.border.small};
              margin: 2 2;
          }

          #workspaces button {
              /* padding: 5 0; */
              padding: 0 5;
              background-color: transparent;
          }

          #workspaces button:hover {
              background: @primary_container;
          }

          #workspaces button.focused, #workspaces button.active {
              background-color: @source_color;
              color: @background;
              /* box-shadow: inset 0 -3px @color3; */
          }

          #workspaces button.urgent {
              background-color: @secondary;
          }

          #language,
          #tray,
          #bluetooth,
          #wireplumber,
          #network,
          #backlight,
          #clock,
          #battery,
          #custom-power {
              margin: 2 2;
              padding: 0 10;
              /* padding: 10 0; */
              color: @on_surface;
              border-radius: ${self.border.small};
          }

          #battery,
          #bluetooth,
          #wireplumber,
          #custom-power,
          #network {
              background-color: @primary_container;
              color: @background;
          }

          /* top right bottom left */
          #battery {
              padding: 0 5 0 10;
              /* padding: 5 0 10 0; */
              border-radius: ${self.border.small} 0 0 ${self.border.small};
              margin: 2 0 2 2;
              /* margin: 2 2 0 2; */
          }

          #battery.bat2 {
              padding: 0 10 0 5;
              /* padding: 10 0 5 0; */
              border-radius: 0 ${self.border.small} ${self.border.small} 0;
              margin: 2 2 2 0;
              /* margin: 0 2 2 2; */
          }

          #custom-power {
              background-color: @source_color;
          }

          #bluetooth:hover,
          #wireplumber:hover,
          #network:hover,
          #custom-power:hover {
              background-color: @on_primary_container;
          }

          #window,
          #workspaces {
              margin: 0 4;
              /* margin: 4 0; */
          }

          /* If workspaces is the leftmost module, omit left margin */
          .modules-left > widget:first-child > #workspaces {
              margin-left: 0;
          }

          /* If workspaces is the rightmost module, omit right margin */
          .modules-right > widget:last-child > #workspaces {
              margin-right: 0;
          }
          '';
        };
      }
    ];
  };
}
