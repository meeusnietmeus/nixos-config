{ pkgs }:
{
    name = "Posy_Cursor_Black";
    package = pkgs.posy-cursors;
    size = 32;
    gtk.enable = true;
    x11.enable = true;
}
