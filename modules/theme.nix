{ self, ... }:
let
  wallpaper = "/home/${self.user}/Pictures/da-man.png";

  font = {
    mono = "JetBrainsMonoNerdFontMono";
    propo = "JetBrainsMonoNerdFontPropo";
    # mono = "IBM Plex Mono";
    # propo = "IBM Plex Mono";
  };

  border = {
    main = "0";
    small = "0";
  };
in {
  flake = {
    inherit font;
    inherit wallpaper;
    inherit border;
  };
}
