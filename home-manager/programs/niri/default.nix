{ config, pkgs, ...}:

{
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

            cursor = {
                theme = "Posy_Cursor_Black";
                size = 32;
            };

            gestures.hot-corners.enable = false;

            layout = {
                gaps = 14;
                center-focused-column = "never";

                default-column-width.proportion = 0.5;

                preset-column-widths = [
                  { proportion = 0.33333; }
                  { proportion = 0.5; }
                  { proportion = 0.66667; }
                ];

                focus-ring = {
                  enable = false;
                };

                shadow = {
                  enable = true;
                  softness = 30.0;
                  spread = 5.0;
                  offset = {
                    x=0;
                    y=5;
                  };
                  draw-behind-window = true;
                  color = "#00000070";
                };
            };

            prefer-no-csd = true;

            spawn-at-startup = [
                { command = [ "waybar" ]; }
                { command = [ "walker" "--gapplication-service" ]; }
                { command = [ "xwayland-satellite" ]; }
                { command = [ "swww-daemon" ]; }
            ];

            environment = {
                DISPLAY = ":0";
            };

            screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
            
            window-rules = [
                {
		  geometry-corner-radius = {
                    bottom-right = 4.0;
                    bottom-left = 4.0;
                    top-left = 4.0;
                    top-right = 4.0;
                  };
                  clip-to-geometry = true;
                }
								{
									# godot 3rd open-window lag fix: open everthing except main window as floating
									matches = [
										{ app-id = "Godot"; }
									];
									excludes = [
										{ title = "^.*Godot Engine$"; }
									];
									open-floating = true;
								}
            ];

            binds = with config.lib.niri.actions; {
                # basics
                "Mod+T".action = spawn "foot";
                "Mod+S".action = spawn "walker";

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
                "Print".action = screenshot;
                #"Ctrl+Print" = screenshot-screen;
                "Alt+Print".action = screenshot-window;
            };
        };
    };
}
