{ config, pkgs, ...}:
{
    programs.waybar = {
        enable = true;
        systemd.enable = true;
        package = pkgs.waybar_git;
        settings = {
            mainBar = {
                layer = "top";
                position = "top";
                height = 30;
                modules-left = [ 
                    "clock" 
                    "battery"
                    "cpu"
                    "memory"
                    "network"
                    #"bluetooth"
                    "pulseaudio"
                ];
                modules-right = [
                    "mpris"
                ];
            };
        };
	};
}