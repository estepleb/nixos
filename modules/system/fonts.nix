{ ... }: {
  flake.nixosModules.fonts = { config, lib, pkgs, ... }: {
    fonts.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "FiraMono" ]; })
      roboto
      work-sans
      comic-neue
      source-sans
      comfortaa
      inter
      lato
      lexend
      jost
      dejavu_fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerd-fonts.fira-code
      nerd-fonts.meslo-lg
      openmoji-color
      twemoji-color-font
      
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      fira
      fira-code
      comic-relief
      inter
      recursive
      iosevka
      iosevka-bin
      iosevka-fixed
      iosevka-fixed-slab
      iosevka-slab
      iosevka-term
      iosevka-term-slab
      symbols-noto
    ];

    fonts.fontconfig = {
      enable = true;
      antialias = true;
      hinting.enable = true;
      subpixel.rgba = "rgb";
    };
  };
}
