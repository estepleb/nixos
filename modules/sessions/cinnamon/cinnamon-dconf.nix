{
  flake.homeModules.cinnamon-dconf = { lib, ... }: with lib.hm.gvariant; {
    # Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
    dconf.settings = {
      "org/cinnamon" = {
        alttab-switcher-delay = 100;
        desklet-snap-interval = 25;
        enabled-applets = [ "panel1:left:0:menu@cinnamon.org:0" "panel1:left:1:separator@cinnamon.org:1" "panel1:left:2:grouped-window-list@cinnamon.org:2" "panel1:right:2:systray@cinnamon.org:3" "panel1:right:3:xapp-status@cinnamon.org:4" "panel1:right:4:notifications@cinnamon.org:5" "panel1:right:5:printers@cinnamon.org:6" "panel1:right:6:removable-drives@cinnamon.org:7" "panel1:right:7:keyboard@cinnamon.org:8" "panel1:right:8:favorites@cinnamon.org:9" "panel1:right:9:network@cinnamon.org:10" "panel1:right:10:sound@cinnamon.org:11" "panel1:right:11:power@cinnamon.org:12" "panel1:right:12:calendar@cinnamon.org:13" "panel1:right:13:cornerbar@cinnamon.org:14" "panel1:right:1:weather@mockturtl:15" "panel1:center:0:workspace-switcher@cinnamon.org:16" ];
        enabled-desklets = [];
        next-applet-id = 17;
        panel-edit-mode = false;
        panel-zone-symbolic-icon-sizes = "[{\"panelId\": 1, \"left\": 28, \"center\": 28, \"right\": 16}]";
        panels-height = [ "1:48" ];
      };

      "org/cinnamon/desktop/a11y/applications" = {
        screen-reader-enabled = false;
      };

      "org/cinnamon/desktop/a11y/mouse" = {
        dwell-click-enabled = false;
        dwell-threshold = 10;
        dwell-time = 1.2;
        secondary-click-enabled = false;
        secondary-click-time = 1.2;
      };

      "org/cinnamon/desktop/applications/calculator" = {
        exec = "gnome-calculator";
      };

      "org/cinnamon/desktop/applications/terminal" = {
        exec = "kitty";
        exec-arg = "--";
      };

      "org/cinnamon/desktop/background" = {
        picture-uri = "file:///home/${config.var.username}/Pictures/clem_calm.jpg";
      };

      "org/cinnamon/desktop/background/slideshow" = {
        delay = 15;
        image-source = "directory:///home/${config.var.username}/Pictures";
      };

      "org/cinnamon/desktop/input-sources" = {
        sources = [ (mkTuple [ "xkb" "us" ]) (mkTuple [ "xkb" "ru" ]) ];
        xkb-options = [ "terminate:ctrl_alt_bksp" "grp:caps_toggle" ];
      };

      "org/cinnamon/desktop/interface" = {
        cursor-blink-time = 1200;
        cursor-size = 24;
        cursor-theme = "Bibata-Modern-Classic";
        gtk-theme = "Mint-Y-Dark";
        icon-theme = "Mint-Y";
        text-scaling-factor = 1.2;
        toolkit-accessibility = false;
      };

      "org/cinnamon/desktop/keybindings" = {
        custom-list = [ "custom0" "custom1" "custom2" ];
      };

      "org/cinnamon/desktop/keybindings/custom-keybindings/custom0" = {
        binding = [ "<Shift><Super>o" ];
        command = "obsidian";
        name = "Obsidian";
      };

      "org/cinnamon/desktop/keybindings/custom-keybindings/custom1" = {
        binding = [ "<Shift><Super>t" ];
        command = "Telegram";
        name = "Telegram";
      };

      "org/cinnamon/desktop/keybindings/custom-keybindings/custom2" = {
        binding = [ "<Shift><Super>g" ];
        command = "godot-mono";
        name = "Godot";
      };

      "org/cinnamon/desktop/keybindings/media-keys" = {
        terminal = [ "<Primary><Alt>t" "<Shift><Super>c" ];
        www = [ "XF86WWW" "<Shift><Super>f" ];
      };

      "org/cinnamon/desktop/keybindings/wm" = {
        close = [ "<Alt>F4" "<Super>c" ];
        minimize = [ "<Super>u" ];
        move-to-center = [ "<Primary><Super>c" ];
        move-to-monitor-down = [ "<Super><Shift>Down" "<Alt><Super>j" ];
        move-to-monitor-left = [ "<Super><Shift>Left" "<Alt><Super>h" ];
        move-to-monitor-right = [ "<Super><Shift>Right" "<Alt><Super>l" ];
        move-to-monitor-up = [ "<Super><Shift>Up" "<Alt><Super>k" ];
        move-to-workspace-1 = [ "<Shift><Super>exclam" ];
        move-to-workspace-10 = [ "<Shift><Super>parenright" ];
        move-to-workspace-2 = [ "<Shift><Super>at" ];
        move-to-workspace-3 = [ "<Shift><Super>numbersign" ];
        move-to-workspace-4 = [ "<Shift><Super>dollar" ];
        move-to-workspace-5 = [ "<Shift><Super>percent" ];
        move-to-workspace-6 = [ "<Shift><Super>asciicircum" ];
        move-to-workspace-7 = [ "<Shift><Super>ampersand" ];
        move-to-workspace-8 = [ "<Shift><Super>asterisk" ];
        move-to-workspace-9 = [ "<Shift><Super>parenleft" ];
        move-to-workspace-down = [ "<Control><Shift><Alt>Down" "<Primary><Shift><Super>j" ];
        move-to-workspace-left = [ "<Control><Shift><Alt>Left" "<Primary><Shift><Super>h" ];
        move-to-workspace-right = [ "<Control><Shift><Alt>Right" "<Primary><Shift><Super>l" ];
        move-to-workspace-up = [ "<Control><Shift><Alt>Up" "<Primary><Shift><Super>k" ];
        push-tile-down = [ "<Super>Down" "<Shift><Super>j" ];
        push-tile-left = [ "<Super>Left" "<Shift><Super>h" ];
        push-tile-right = [ "<Super>Right" "<Shift><Super>l" ];
        push-tile-up = [ "<Super>Up" "<Shift><Super>k" ];
        switch-input-source = [ "ISO_Next_Group" "XF86Keyboard" ];
        switch-to-workspace-1 = [ "<Super>1" ];
        switch-to-workspace-10 = [ "<Super>0" ];
        switch-to-workspace-2 = [ "<Super>2" ];
        switch-to-workspace-3 = [ "<Super>3" ];
        switch-to-workspace-4 = [ "<Super>4" ];
        switch-to-workspace-5 = [ "<Super>5" ];
        switch-to-workspace-6 = [ "<Super>6" ];
        switch-to-workspace-7 = [ "<Super>7" ];
        switch-to-workspace-8 = [ "<Super>8" ];
        switch-to-workspace-9 = [ "<Super>9" ];
        switch-to-workspace-down = [ "<Control><Alt>Down" "<Super>w" ];
        switch-to-workspace-left = [ "<Primary><Super>Left" "<Primary><Super>h" ];
        switch-to-workspace-right = [ "<Primary><Super>Right" "<Primary><Super>l" ];
        toggle-fullscreen = [ "<Super>f" "F11" ];
        toggle-maximized = [ "<Alt>F10" "<Super>m" ];
      };

      "org/cinnamon/desktop/media-handling" = {
        autorun-never = false;
      };

      "org/cinnamon/desktop/peripherals/keyboard" = {
        delay = mkUint32 228;
        repeat-interval = mkUint32 30;
      };

      "org/cinnamon/desktop/peripherals/mouse" = {
        accel-profile = "flat";
        double-click = 400;
        drag-threshold = 8;
        speed = 0.0;
      };

      "org/cinnamon/desktop/peripherals/touchpad" = {
        speed = 0.0;
      };

      "org/cinnamon/desktop/screensaver" = {
        layout-group = 0;
      };

      "org/cinnamon/desktop/sound" = {
        event-sounds = false;
      };

      "org/cinnamon/desktop/wm/preferences" = {
        min-window-opacity = 30;
        mouse-button-modifier = "<Super>";
      };

      "org/cinnamon/gestures" = {
        enabled = true;
        pinch-percent-threshold = mkUint32 40;
        swipe-down-2 = "PUSH_TILE_DOWN::end";
        swipe-down-3 = "TOGGLE_OVERVIEW::::start";
        swipe-down-4 = "VOLUME_DOWN::end";
        swipe-left-2 = "PUSH_TILE_LEFT::end";
        swipe-left-3 = "WORKSPACE_NEXT::::start";
        swipe-left-4 = "WINDOW_WORKSPACE_PREVIOUS::end";
        swipe-percent-threshold = mkUint32 60;
        swipe-right-2 = "PUSH_TILE_RIGHT::end";
        swipe-right-3 = "WORKSPACE_PREVIOUS::::start";
        swipe-right-4 = "WINDOW_WORKSPACE_NEXT::end";
        swipe-up-2 = "PUSH_TILE_UP::end";
        swipe-up-3 = "TOGGLE_EXPO::::start";
        swipe-up-4 = "VOLUME_UP::end";
        tap-3 = "MEDIA_PLAY_PAUSE::end";
      };

      "org/cinnamon/muffin" = {
        draggable-border-width = 10;
        placement-mode = "center";
        tile-maximize = true;
      };

      "org/cinnamon/settings-daemon/plugins/color" = {
        night-light-last-coordinates = mkTuple [ 43.25 76.95 ];
      };

      "org/cinnamon/theme" = {
        name = "Mint-Y-Dark";
      };
    };
  };
}
