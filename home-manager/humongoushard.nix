{ config, pkgs, ... }:

{
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

	programs.waybar = {
		enable = true;
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

  services.mako = {
    enable = true;
  };
}
