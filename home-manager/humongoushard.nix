{ config, pkgs, inputs, ... }:

{
  # Add the niri home-manager module
  imports = [
    inputs.niri.homeModules.niri
  ];

  home.stateVersion = "25.05"; # dont touch, original install version
  home.username = "humongoushard";
  home.homeDirectory = "/home/humongoushard";

  home.packages = with pkgs; [
    walker
    btop

    # Apps
    vscode
    discord
    spotify
    obsidian
    firefox
    blender
  ];

  programs.foot = {
    enable = true;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };

  programs.git = {
    enable = true;
    userName = "meeusnietmeus";
    userEmail = "91123727+meeusnietmeus@users.noreply.github.com";
  };

  programs.niri = { 
    enable = true;
    settings = {
      hotkey-overlay.skip-at-startup = true;

      input = {
        keyboard = {
          numlock = true;
        };

        touchpad = {
          tap = true;
          natural-scroll = true;
          accel-speed = 0.4;
        };

        mouse = {
          accel-speed = 0.15;
        };
      };

      gestures.hot-corners.off = true;

      layout = {
        gaps = 14;
        center-focused-column = "never";

        default-column-width { proportion = 0.5; };
        preset-column-widths = {
          proportion = 0.33333;
          proportion = 0.5;
          proportion = 0.66667;
        };

        focus-ring = {
          width = 3;
          active-color = "#7fc8ff";
          inactive-color = "#505050";
        };
      };

      prefer-no-csd = true;

      spawn-at-startup = [
        { command = [ "waybar" ]; }
        { command = [ "walker" "--gapplication-service" ]; }
        { command = [ "xwayland-satellite" ]; }
      ];

      environment = {
        DISPLAY = ":0";
      };

      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
      
      window-rules = [
        {
          # Open the Firefox picture-in-picture player as floating by default.
          matches = [
            { app-id = "firefox$" }
            { title = "^Picture-in-Picture$" }
          ];
          open-floating = true;
        }
        {
          geometry-corner-radius = 4;
          clip-to-geometry = true;
        }
      ];

      binds = with config.lib.niri.actions; {
        # basics
        "Mod+T".action = spawn "foot";
        "Mod+D".action = spawn "walker";

        # volume keymaps for pipewire 
        "XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
        };
        "XF86AudioLowerVolume" = {
          allow-when-locked = true;
          action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
        };
        "XF86AudioMute" = {
          allow-when-locked = true;
          action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
        };

        # navigation
        "Mod+Q".action = close-window;     

        "Mod+O" = {
          repeat = false;
          action = toggle-overview;
        };

        "Mod+H".action = focus-column-left;
        "Mod+J".action = focus-window-down;
        "Mod+K".action = focus-window-up;
        "Mod+L".action = focus-column-right;

        "Mod+Ctrl+H".action = move-column-left;
        "Mod+Ctrl+J".action = move-window-down;
        "Mod+Ctrl+K".action = move-window-up;
        "Mod+Ctrl+L".action = move-column-right;

        "Mod+U".action = focus-workspace-down;
        "Mod+I".action = focus-workspace-up;
        
        "Mod+Ctrl+U".action = move-column-to-workspace-down;
        "Mod+Ctrl+I".action = move-column-to-workspace-up;

        # mouse (especially neat for trackpad)
        "Mod+WheelScrollDown" = {
          cooldown-ms = 150;
          action = focus-workspace-down;
        };
        "Mod+WheelScrollUp" = {
          cooldown-ms = 150;
          action = focus-workspace-up;
        };
        "Mod+WheelScrollLeft".action = focus-column-left;
        "Mod+WheelScrollRight".action = focus-column-right;

        # workspaces
        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;

        # extraz
        "Mod+F".action = maximize-column;
        "Mod+V".action = toggle-window-floating;

        # screenshotting
        "Print" = screenshot;
        "Ctrl+Print" = screenshot-screen;
        "Alt+Print" = screenshot-window;
      }
    }
  };

	programs.waybar = {
		enable = true;
    systemd.enable = true;
		package = pkgs.waybar_git;
		settings = {
		  mainBar = {
		    layer = "top";
		    position = "top";
		    height = 30;
		    modules-left = [ "clock" ];
		  };
		};
	};

  programs.home-manager.enable = true;

  services.mako = {
    enable = true;
  };
}
