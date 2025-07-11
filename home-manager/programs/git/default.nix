{ config, pkgs, ...}:
{
    programs.git = {
        enable = true;
        userName = "meeusnietmeus";
        userEmail = "91123727+meeusnietmeus@users.noreply.github.com";
    };
}