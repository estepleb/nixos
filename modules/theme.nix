{ self, ... }:
let
  wallpaper = "/home/${self.user}/Pictures/iriza-katou.jpg";

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
