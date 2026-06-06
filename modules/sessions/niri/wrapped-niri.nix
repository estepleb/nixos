{ self, inputs, ... }:
{
  flake.nixosModules.wrappedNiri = { pkgs, lib, ... }:
  {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.wrappedNiri;
    };
  };
  perSystem = { pkgs, lib, ... }: {
    packages.wrappedNiri = inputs.wrappers.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        input = {
          keyboard = {
            xkb = {
              layout = "us,ru";
              options = "grp:caps_toggle";
            };
            repeat-delay = 250;
            repeat-rate = 25;
          };

          touchpad = {
            tap = null;
            natural-scroll = null;
          };

          mouse = {
            accel-profile = "flat";
          };

          trackpoint = {
            accel-profile = "flat";
          };

          warp-mouse-to-focus = null;
          # focus-follows-mouse.max-scroll-amount = "95%";
        };

        outputs."eDP-1" = {
          mode = "1920x1080@60";
          scale = 1;
          transform = "normal";
        };

        layout = {
          gaps = 8;
          always-center-single-column = null;
          center-focused-column = "never";

          preset-column-widths = [
            { proportion = 0.33333; }
            { proportion = 0.5; }
            { proportion = 0.66667; }
          ];

          default-column-width.proportion = 0.5;

          focus-ring = {
            width = 3;
            active-color = "#77863D";
            inactive-color = "#505050";
          };

          border = {
            off = null;
            width = 2;
            active-color = "#ffc87f";
            inactive-color = "#505050";
            urgent-color = "#9b0000";
          };

          shadow = {
            softness = 30;
            spread = 5;
            # offset = "x=0 y=5";
            color = "#0007";
          };

          struts = { };
        };

        spawn-at-startup = [
          "waybar"
          "dunst"
        ];

        spawn-sh-at-startup = [
          "swaybg -i /mnt/data/pictures/Bierstadt_Mount_Baker_Washington.jpg"
          "wlsunset -l 43.2 -L 76.9 -t 5000"
          "wal -i /mnt/data/pictures/Bierstadt_Mount_Baker_Washington.jpg --cols16"
          "matugen image /mnt/data/pictures/Bierstadt_Mount_Baker_Washington.jpg"
        ];

        hotkey-overlay.skip-at-startup = null;
        prefer-no-csd = null;

        screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

        animations = { };

        window-rules = [
          {
            matches = [
              {
                app-id = "firefox$";
                title = "^Picture-in-Picture$";
              }
            ];
            open-floating = true;
          }
        ];

        binds = {
          "Mod+Shift+Slash".show-hotkey-overlay = null;

          "Mod+Shift+G".spawn-sh = "godot-mono";

          "Mod+Shift+O".spawn-sh = "obsidian";

          "Mod+Shift+F".spawn-sh = "zen";

          "Mod+Shift+T".spawn-sh = "Telegram";

          "Mod+Shift+C".spawn-sh = "kitty";

          "Mod+E".spawn-sh = "nautilus";

          "Mod+P".spawn-sh = "wofi --show drun";

          "XF86AudioRaiseVolume" = {
            allow-when-locked = true;
            spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.0";
          };

          "XF86AudioLowerVolume" = {
            allow-when-locked = true;
            spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
          };

          "XF86AudioMute" = {
            allow-when-locked = true;
            spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          };

          "XF86AudioMicMute" = {
            allow-when-locked = true;
            spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          };

          "XF86AudioPlay" = {
            allow-when-locked = true;
            spawn-sh = "playerctl play-pause";
          };

          "XF86AudioStop" = {
            allow-when-locked = true;
            spawn-sh = "playerctl stop";
          };

          "XF86AudioPrev" = {
            allow-when-locked = true;
            spawn-sh = "playerctl previous";
          };

          "XF86AudioNext" = {
            allow-when-locked = true;
            spawn-sh = "playerctl next";
          };

          "XF86MonBrightnessUp" = {
            allow-when-locked = true;
            spawn-sh = "brightnessctl --class=backlight set +5%";
          };

          "XF86MonBrightnessDown" = {
            allow-when-locked = true;
            spawn-sh = "brightnessctl --class=backlight set 5%-";
          };

          "Mod+O" = {
            repeat = false;
            toggle-overview = null;
          };

          "Mod+C" = {
            repeat = false;
            close-window = null;
          };

          "Mod+Left".focus-column-left = null;
          "Mod+Down".focus-window-down = null;
          "Mod+Up".focus-window-up = null;
          "Mod+Right".focus-column-right = null;
          "Mod+H".focus-column-left = null;
          "Mod+J".focus-window-down = null;
          "Mod+K".focus-window-up = null;
          "Mod+L".focus-column-right = null;

          "Mod+Shift+Left".move-column-left = null;
          "Mod+Shift+Down".move-window-down = null;
          "Mod+Shift+Up".move-window-up = null;
          "Mod+Shift+Right".move-column-right = null;
          "Mod+Shift+H".move-column-left = null;
          "Mod+Shift+J".move-window-down = null;
          "Mod+Shift+K".move-window-up = null;
          "Mod+Shift+L".move-column-right = null;

          "Mod+Home".focus-column-first = null;
          "Mod+End".focus-column-last = null;
          "Mod+Ctrl+Home".move-column-to-first = null;
          "Mod+Ctrl+End".move-column-to-last = null;

          "Mod+Ctrl+Left".focus-monitor-left = null;
          "Mod+Ctrl+Down".focus-monitor-down = null;
          "Mod+Ctrl+Up".focus-monitor-up = null;
          "Mod+Ctrl+Right".focus-monitor-right = null;
          "Mod+Ctrl+H".focus-monitor-left = null;
          "Mod+Ctrl+J".focus-monitor-down = null;
          "Mod+Ctrl+K".focus-monitor-up = null;
          "Mod+Ctrl+L".focus-monitor-right = null;

          "Mod+Shift+Ctrl+Left".move-column-to-monitor-left = null;
          "Mod+Shift+Ctrl+Down".move-column-to-monitor-down = null;
          "Mod+Shift+Ctrl+Up".move-column-to-monitor-up = null;
          "Mod+Shift+Ctrl+Right".move-column-to-monitor-right = null;
          "Mod+Shift+Ctrl+H".move-column-to-monitor-left = null;
          "Mod+Shift+Ctrl+J".move-column-to-monitor-down = null;
          "Mod+Shift+Ctrl+K".move-column-to-monitor-up = null;
          "Mod+Shift+Ctrl+L".move-column-to-monitor-right = null;

          "Mod+Page_Down".focus-workspace-down = null;
          "Mod+Page_Up".focus-workspace-up = null;
          "Mod+U".focus-workspace-down = null;
          "Mod+I".focus-workspace-up = null;

          "Mod+Ctrl+Page_Down".move-column-to-workspace-down = null;
          "Mod+Ctrl+Page_Up".move-column-to-workspace-up = null;
          "Mod+Ctrl+U".move-column-to-workspace-down = null;
          "Mod+Ctrl+I".move-column-to-workspace-up = null;

          "Mod+Shift+Page_Down".move-workspace-down = null;
          "Mod+Shift+Page_Up".move-workspace-up = null;
          "Mod+Shift+U".move-workspace-down = null;
          "Mod+Shift+I".move-workspace-up = null;

          "Mod+WheelScrollDown" = {
            cooldown-ms = 150;
            focus-workspace-down = null;
          };

          "Mod+WheelScrollUp" = {
            cooldown-ms = 150;
            focus-workspace-up = null;
          };

          "Mod+Ctrl+WheelScrollDown" = {
            cooldown-ms = 150;
            move-column-to-workspace-down = null;
          };

          "Mod+Ctrl+WheelScrollUp" = {
            cooldown-ms = 150;
            move-column-to-workspace-up = null;
          };

          "Mod+WheelScrollRight".focus-column-right = null;
          "Mod+WheelScrollLeft".focus-column-left = null;
          "Mod+Ctrl+WheelScrollRight".move-column-right = null;
          "Mod+Ctrl+WheelScrollLeft".move-column-left = null;

          "Mod+Shift+WheelScrollDown".focus-column-right = null;
          "Mod+Shift+WheelScrollUp".focus-column-left = null;
          "Mod+Ctrl+Shift+WheelScrollDown".move-column-right = null;
          "Mod+Ctrl+Shift+WheelScrollUp".move-column-left = null;

          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+6".focus-workspace = 6;
          "Mod+7".focus-workspace = 7;
          "Mod+8".focus-workspace = 8;
          "Mod+9".focus-workspace = 9;

          "Mod+Shift+1".move-column-to-workspace = 1;
          "Mod+Shift+2".move-column-to-workspace = 2;
          "Mod+Shift+3".move-column-to-workspace = 3;
          "Mod+Shift+4".move-column-to-workspace = 4;
          "Mod+Shift+5".move-column-to-workspace = 5;
          "Mod+Shift+6".move-column-to-workspace = 6;
          "Mod+Shift+7".move-column-to-workspace = 7;
          "Mod+Shift+8".move-column-to-workspace = 8;
          "Mod+Shift+9".move-column-to-workspace = 9;

          "Mod+Comma".consume-or-expel-window-left = null;
          "Mod+Period".consume-or-expel-window-right = null;
          "Mod+Shift+Comma".consume-window-into-column = null;
          "Mod+Shift+Period".expel-window-from-column = null;

          "Mod+R".switch-preset-column-width = null;
          "Mod+Shift+R".switch-preset-window-height = null;
          "Mod+Ctrl+R".reset-window-height = null;
          "Mod+M".maximize-column = null;
          "Mod+F".fullscreen-window = null;
          "Mod+Ctrl+F".expand-column-to-available-width = null;
          "Mod+Alt+C".center-column = null;
          "Mod+Ctrl+C".center-visible-columns = null;

          "Mod+Minus".set-column-width = "-10%";
          "Mod+Equal".set-column-width = "+10%";
          "Mod+Shift+Minus".set-window-height = "-10%";
          "Mod+Shift+Equal".set-window-height = "+10%";

          "Mod+V".toggle-window-floating = null;
          "Mod+Shift+V".switch-focus-between-floating-and-tiling = null;
          "Mod+W".toggle-column-tabbed-display = null;

          "Print".screenshot = null;
          "Ctrl+Print".screenshot-screen = null;
          "Alt+Print".screenshot-window = null;

          "Mod+Escape" = {
            allow-inhibiting = false;
            toggle-keyboard-shortcuts-inhibit = null;
          };

          "Mod+Shift+E".quit = null;
          "Ctrl+Alt+Delete".quit = null;
          "Mod+Shift+P".power-off-monitors = null;
        };
      };
    };
  };
}
