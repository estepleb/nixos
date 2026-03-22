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

    home-manager.users.matthew.imports = [
    {
      programs.waybar = {
        enable = true;
        settings = {
          bar = {
            height = 24;
            spacing = 4;
            modules-left = [ "niri/workspaces" ];
            modules-center = [ "niri/window" ];
            modules-right = [ "niri/language" "tray" "wireplumber" "network" "bluetooth" "power-profiles-daemon" "backlight" "battery" "battery#bat2" "clock" "custom/power" ];
            "niri/workspaces" = {
              "disable-scroll" = true;
              "all-outputs" = true;
              "warp-on-scroll" = false;
              "format" = "{icon}";
            };
            "tray" = {
                "spacing" = 10;
            };
            "clock" = {
                "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
                "format-alt" = "{:%Y-%m-%d}";
            };
            "backlight" = {
                "format" = "{percent}% {icon}";
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
                "format-charging" = " {capacity}%";
                "format-plugged" = " {capacity}%";
                "format-alt" = "{icon} {time}";
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
                "format-alt" = "{icon} {time}";
                "format-icons" = ["" "" "" "" ""];
            };
            "power-profiles-daemon" = {
              "format" = "{icon}";
              "tooltip-format" = "Power profile: {profile}\nDriver: {driver}";
              "tooltip" = true;
              "format-icons" = {
                "default" = "";
                "performance" = "";
                "balanced" = "";
                "power-saver" = "";
              };
            };
            "bluetooth" = {
                "format" = "";
                "format-off" = "󰂲";
                "on-click" = "kitty --hold sh -c 'bluetui'";
            };
            "network" = {
                "format-wifi" = "  {essid}";
                "format-disconnected" = "󰖪";
                "on-click" = "kitty --hold sh -c 'nmtui'";
            };
            "wireplumber" = {
                "format" = "{icon}  {volume}%";
                "format-muted" = " ";
                "format-icons" = {
                    "default" = ["" "" ""];
                };
                "on-click" = "kitty --hold sh -c 'wiremix'";
            };
            "custom/power" = {
                "format"  = "⏻ ";
                "on-click" = "systemctl suspend";
                # "shutdown" = "shutdown";
                # "reboot" = "reboot";
                # "suspend" = "systemctl suspend";
                # "hibernate" = "systemctl hibernate"
            };
          };
        };

        style = /*css*/ ''
          @import "/home/matthew/.cache/wal/colors-waybar.css";

            * {
                /* `otf-font-awesome` is required to be installed for icons */
                font-family: FontAwesome, JetBrainsMonoNerdFont;
                font-size: 13pt;
            }

            window#waybar {
                background-color: @background;
                color: @cursor;
                transition-property: background-color;
                transition-duration: .5s;
            }

            button {
                /* Use box-shadow instead of border so the text isn't offset */
                box-shadow: inset 0 -3px transparent;
                /* Avoid rounded borders under each button name */
                border: none;
                border-radius: 0;
            }

            #workspaces button {
                padding: 0 5px;
                background-color: transparent;
            }

            #workspaces button:hover {
                background: rgba(0, 0, 0, 0.2);
            }

            #workspaces button.focused, #workspaces button.active {
                background-color: @color2;
                /* box-shadow: inset 0 -3px @color3; */
            }

            #workspaces button.urgent {
                background-color: @color4;
            }

            #language,
            #tray,
            #bluetooth,
            #wireplumber,
            #network,
            #backlight,
            #power-profiles-daemon,
            #battery,
            #clock,
            #power {
                padding: 0 10px;
                color: @cursor;
            }

            #window,
            #workspaces {
                margin: 0 4px;
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
