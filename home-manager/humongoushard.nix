{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.niri.homeModules.niri
    inputs.nixvim.homeModules.nixvim

    # program configs
    ./programs/bash
    ./programs/fish
    ./programs/foot
    ./programs/git
    ./programs/direnv
    ./programs/niri
    ./programs/waybar
    ./programs/yazi
    ./programs/nixvim

    # services configs
    ./services/mako
  ];

  home.stateVersion = "25.05"; # dont touch, original install version
  home.username = "humongoushard";
  home.homeDirectory = "/home/humongoushard";

  home.pointerCursor = import ./cursor { inherit pkgs; };

  home.packages = with pkgs; [
    walker

    # CLI tools
    btop
    unzip

    # required stuff
    nautilus
    playerctl

    #yuhh
    gcc

    # Apps
    vscode
    discord
    spotify
    obsidian

    # game dev
    blender
    jetbrains.rider
    mypaint
    godot-mono

    # browsers
    google-chrome
    brave
    firefox
  ];
}
