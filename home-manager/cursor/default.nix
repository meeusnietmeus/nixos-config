{ pkgs }:

let
  my-cursors = pkgs.stdenv.mkDerivation {
    name = "Posy's Cursor Black";
    src = ./files;
    
    installPhase = ''
      mkdir -p $out/share/icons
      cp -r * $out/share/icons/
    '';
  };
in
{
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 32;
    gtk.enable = true;
    x11.enable = true;
}
