{ self, ... }:
{
  flake.nixosModules.hyprland-default = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.ly
    ];

    programs.hyprland = {
      enable = true;
      withUWSM = true; # recommended for most users
      xwayland.enable = true; # Xwayland can be disabled.
    };

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
    };

    home-manager.users.${self.user} = {
      wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = false;
	configType = "lua";

	settings = {
	  monitor = {
	    output = "";
	    mode = "preferred";
	    position = "auto";
	    scale = "1.0";
	  };

	  env = [
	    {
	      _args = [ "XCURSOR_SIZE" "24" ];
	    }

	    {
	      _args = [ "HYPRCURSOR_SIZE" "24" ];
	    }
	  ];

	  config = {
	    general = {
	      gaps_in = 5;
	      gaps_out = 20;
	      border_size = 2;

	      col = {
		active_border = {
		  colors = [
		    "rgba(33ccffee)"
		    "rgba(00ff99ee)"
		  ];
		  angle = 45;
		};

		inactive_border = "rgba(595959aa)";
	      };

	      resize_on_border = false;
	      allow_tearing = false;
	      layout = "dwindle";
	    };

	    decoration = {
	      rounding = 10;
	      rounding_power = 2;

	      active_opacity = 1.0;
	      inactive_opacity = 1.0;

	      shadow = {
		enabled = true;
		range = 4;
		render_power = 3;
		color = lib.generators.mkLuaInline "0xee1a1a1a";
	      };

	      blur = {
		enabled = true;
		size = 3;
		passes = 1;
		vibrancy = 0.1696;
	      };
	    };

	    animations = {
	      enabled = true;
	    };

	    dwindle = {
	      preserve_split = true;
	    };

	    master = {
	      new_status = "master";
	    };

	    scrolling = {
	      fullscreen_on_one_column = true;
	    };

	    misc = {
	      force_default_wallpaper = -1;
	      disable_hyprland_logo = false;
	    };

	    input = {
	      kb_layout = "us";
	      kb_variant = "";
	      kb_model = "";
	      kb_options = "";
	      kb_rules = "";

	      follow_mouse = 1;
	      sensitivity = 0;

	      touchpad = {
		natural_scroll = false;
	      };
	    };
	  };

	  curve = [
	    {
	      _args = [
		"easeOutQuint"
		{
		  type = "bezier";
		  points = [
		    [ 0.23 1 ]
		    [ 0.32 1 ]
		  ];
		}
	      ];
	    }

	    {
	      _args = [
		"easeInOutCubic"
		{
		  type = "bezier";
		  points = [
		    [ 0.65 0.05 ]
		    [ 0.36 1 ]
		  ];
		}
	      ];
	    }

	    {
	      _args = [
		"linear"
		{
		  type = "bezier";
		  points = [
		    [ 0 0 ]
		    [ 1 1 ]
		  ];
		}
	      ];
	    }

	    {
	      _args = [
		"almostLinear"
		{
		  type = "bezier";
		  points = [
		    [ 0.5 0.5 ]
		    [ 0.75 1 ]
		  ];
		}
	      ];
	    }

	    {
	      _args = [
		"quick"
		{
		  type = "bezier";
		  points = [
		    [ 0.15 0 ]
		    [ 0.1 1 ]
		  ];
		}
	      ];
	    }

	    {
	      _args = [
		"easy"
		{
		  type = "spring";
		  mass = 1;
		  stiffness = 71.2633;
		  dampening = 15.8273644;
		}
	      ];
	    }
	  ];

	  animation = [
	    {
	      leaf = "global";
	      enabled = true;
	      speed = 10;
	      bezier = "default";
	    }

	    {
	      leaf = "border";
	      enabled = true;
	      speed = 5.39;
	      bezier = "easeOutQuint";
	    }

	    {
	      leaf = "windows";
	      enabled = true;
	      speed = 4.79;
	      spring = "easy";
	    }

	    {
	      leaf = "windowsIn";
	      enabled = true;
	      speed = 4.1;
	      spring = "easy";
	      style = "popin 87%";
	    }

	    {
	      leaf = "windowsOut";
	      enabled = true;
	      speed = 1.49;
	      bezier = "linear";
	      style = "popin 87%";
	    }

	    {
	      leaf = "fadeIn";
	      enabled = true;
	      speed = 1.73;
	      bezier = "almostLinear";
	    }

	    {
	      leaf = "fadeOut";
	      enabled = true;
	      speed = 1.46;
	      bezier = "almostLinear";
	    }

	    {
	      leaf = "fade";
	      enabled = true;
	      speed = 3.03;
	      bezier = "quick";
	    }

	    {
	      leaf = "layers";
	      enabled = true;
	      speed = 3.81;
	      bezier = "easeOutQuint";
	    }

	    {
	      leaf = "layersIn";
	      enabled = true;
	      speed = 4;
	      bezier = "easeOutQuint";
	      style = "fade";
	    }

	    {
	      leaf = "layersOut";
	      enabled = true;
	      speed = 1.5;
	      bezier = "linear";
	      style = "fade";
	    }

	    {
	      leaf = "fadeLayersIn";
	      enabled = true;
	      speed = 1.79;
	      bezier = "almostLinear";
	    }

	    {
	      leaf = "fadeLayersOut";
	      enabled = true;
	      speed = 1.39;
	      bezier = "almostLinear";
	    }

	    {
	      leaf = "workspaces";
	      enabled = true;
	      speed = 1.94;
	      bezier = "almostLinear";
	      style = "fade";
	    }

	    {
	      leaf = "workspacesIn";
	      enabled = true;
	      speed = 1.21;
	      bezier = "almostLinear";
	      style = "fade";
	    }

	    {
	      leaf = "workspacesOut";
	      enabled = true;
	      speed = 1.94;
	      bezier = "almostLinear";
	      style = "fade";
	    }

	    {
	      leaf = "zoomFactor";
	      enabled = true;
	      speed = 7;
	      bezier = "quick";
	    }
	  ];

	  gesture = {
	    fingers = 3;
	    direction = "horizontal";
	    action = "workspace";
	  };

	  device = {
	    name = "epic-mouse-v1";
	    sensitivity = -0.5;
	  };

	  bind = [
	    {
	      _args = [
		"SUPER + Q"
		(lib.generators.mkLuaInline ''hl.dsp.exec_cmd("kitty")'')
	      ];
	    }

	    {
	      _args = [
		"SUPER + C"
		(lib.generators.mkLuaInline "hl.dsp.window.close()")
	      ];
	    }

	    {
	      _args = [
		"SUPER + M"
		(lib.generators.mkLuaInline ''hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")'')
	      ];
	    }

	    {
	      _args = [
		"SUPER + E"
		(lib.generators.mkLuaInline ''hl.dsp.exec_cmd("dolphin")'')
	      ];
	    }

	    {
	      _args = [
		"SUPER + V"
		(lib.generators.mkLuaInline ''hl.dsp.window.float({ action = "toggle" })'')
	      ];
	    }

	    {
	      _args = [
		"SUPER + R"
		(lib.generators.mkLuaInline ''hl.dsp.exec_cmd("hyprlauncher")'')
	      ];
	    }

	    {
	      _args = [
		"SUPER + P"
		(lib.generators.mkLuaInline "hl.dsp.window.pseudo()")
	      ];
	    }

	    {
	      _args = [
		"SUPER + J"
		(lib.generators.mkLuaInline ''hl.dsp.layout("togglesplit")'')
	      ];
	    }

	    {
	      _args = [
		"SUPER + left"
		(lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "left" })'')
	      ];
	    }

	    {
	      _args = [
		"SUPER + right"
		(lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "right" })'')
	      ];
	    }

	    {
	      _args = [
		"SUPER + up"
		(lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "up" })'')
	      ];
	    }

	    {
	      _args = [
		"SUPER + down"
		(lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "down" })'')
	      ];
	    }

	    {
	      _args = [
		"SUPER + 1"
		(lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 1 })")
	      ];
	    }

	    {
	      _args = [
		"SUPER + 2"
		(lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 2 })")
	      ];
	    }

	    {
	      _args = [
		"SUPER + 3"
		(lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 3 })")
	      ];
	    }

	    {
	      _args = [
		"SUPER + 4"
		(lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 4 })")
	      ];
	    }

	    {
	      _args = [
		"SUPER + 5"
		(lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 5 })")
	      ];
	    }

	    {
	      _args = [
		"SUPER + 6"
		(lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 6 })")
	      ];
	    }

	    {
	      _args = [
		"SUPER + 7"
		(lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 7 })")
	      ];
	    }

	    {
	      _args = [
		"SUPER + 8"
		(lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 8 })")
	      ];
	    }

	    {
	      _args = [
		"SUPER + 9"
		(lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 9 })")
	      ];
	    }

	    {
	      _args = [
		"SUPER + 0"
		(lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 10 })")
	      ];
	    }

	    {
	      _args = [
		"SUPER + SHIFT + 1"
		(lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 1 })")
	      ];
	    }

	    {
	      _args = [
		"SUPER + SHIFT + 2"
		(lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 2 })")
	      ];
	    }

	    {
	      _args = [
		"SUPER + SHIFT + 3"
		(lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 3 })")
	      ];
	    }

	    {
	      _args = [
		"SUPER + SHIFT + 4"
		(lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 4 })")
	      ];
	    }

	    {
	      _args = [
		"SUPER + SHIFT + 5"
		(lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 5 })")
	      ];
	    }

	    {
	      _args = [
		"SUPER + SHIFT + 6"
		(lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 6 })")
	      ];
	    }

	    {
	      _args = [
		"SUPER + SHIFT + 7"
		(lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 7 })")
	      ];
	    }

	    {
	      _args = [
		"SUPER + SHIFT + 8"
		(lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 8 })")
	      ];
	    }

	    {
	      _args = [
		"SUPER + SHIFT + 9"
		(lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 9 })")
	      ];
	    }

	    {
	      _args = [
		"SUPER + SHIFT + 0"
		(lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 10 })")
	      ];
	    }

	    {
	      _args = [
		"SUPER + S"
		(lib.generators.mkLuaInline ''hl.dsp.workspace.toggle_special("magic")'')
	      ];
	    }

	    {
	      _args = [
		"SUPER + SHIFT + S"
		(lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = "special:magic" })'')
	      ];
	    }

	    {
	      _args = [
		"SUPER + mouse_down"
		(lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "e+1" })'')
	      ];
	    }

	    {
	      _args = [
		"SUPER + mouse_up"
		(lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "e-1" })'')
	      ];
	    }

	    {
	      _args = [
		"SUPER + mouse:272"
		(lib.generators.mkLuaInline "hl.dsp.window.drag()")
		{ mouse = true; }
	      ];
	    }

	    {
	      _args = [
		"SUPER + mouse:273"
		(lib.generators.mkLuaInline "hl.dsp.window.resize()")
		{ mouse = true; }
	      ];
	    }

	    {
	      _args = [
		"XF86AudioRaiseVolume"
		(lib.generators.mkLuaInline ''hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+")'')
		{
		  locked = true;
		  repeating = true;
		}
	      ];
	    }

	    {
	      _args = [
		"XF86AudioLowerVolume"
		(lib.generators.mkLuaInline ''hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")'')
		{
		  locked = true;
		  repeating = true;
		}
	      ];
	    }

	    {
	      _args = [
		"XF86AudioMute"
		(lib.generators.mkLuaInline ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")'')
		{
		  locked = true;
		  repeating = true;
		}
	      ];
	    }

	    {
	      _args = [
		"XF86AudioMicMute"
		(lib.generators.mkLuaInline ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")'')
		{
		  locked = true;
		  repeating = true;
		}
	      ];
	    }

	    {
	      _args = [
		"XF86MonBrightnessUp"
		(lib.generators.mkLuaInline ''hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+")'')
		{
		  locked = true;
		  repeating = true;
		}
	      ];
	    }

	    {
	      _args = [
		"XF86MonBrightnessDown"
		(lib.generators.mkLuaInline ''hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-")'')
		{
		  locked = true;
		  repeating = true;
		}
	      ];
	    }

	    {
	      _args = [
		"XF86AudioNext"
		(lib.generators.mkLuaInline ''hl.dsp.exec_cmd("playerctl next")'')
		{ locked = true; }
	      ];
	    }

	    {
	      _args = [
		"XF86AudioPause"
		(lib.generators.mkLuaInline ''hl.dsp.exec_cmd("playerctl play-pause")'')
		{ locked = true; }
	      ];
	    }

	    {
	      _args = [
		"XF86AudioPlay"
		(lib.generators.mkLuaInline ''hl.dsp.exec_cmd("playerctl play-pause")'')
		{ locked = true; }
	      ];
	    }

	    {
	      _args = [
		"XF86AudioPrev"
		(lib.generators.mkLuaInline ''hl.dsp.exec_cmd("playerctl previous")'')
		{ locked = true; }
	      ];
	    }
	  ];

	  window_rule = [
	    {
	      name = "suppress-maximize-events";
	      match = {
		class = ".*";
	      };
	      suppress_event = "maximize";
	    }

	    {
	      name = "fix-xwayland-drags";
	      match = {
		class = "^$";
		title = "^$";
		xwayland = true;
		float = true;
		fullscreen = false;
		pin = false;
	      };
	      no_focus = true;
	    }

	    {
	      name = "move-hyprland-run";
	      match = {
		class = "hyprland-run";
	      };
	      move = "20 monitor_h-120";
	      float = true;
	    }
	  ];
	};
      };
    };
  };
}
