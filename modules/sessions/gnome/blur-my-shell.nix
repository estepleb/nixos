# This file was written by ChatGPT 5.5 extended.
# And I'm not proud of this, 
# yet it works.

{
  flake.nixosModules.blur-my-shell = { pkgs, lib, ... }: 
let
  mutterMajor = lib.versions.major pkgs.mutter.version;

  # GNOME 49 = libmutter-17, GNOME 50 = libmutter-18
  mutterApi = {
    "49" = "17";
    "50" = "18";
  }.${mutterMajor} or (throw "Unsupported Mutter major: ${mutterMajor}");

  gnomeRoundedBlur = pkgs.stdenv.mkDerivation {
    pname = "gnome-rounded-blur";
    version = "1.0.1";

    src = pkgs.fetchFromGitHub {
      owner = "kancko";
      repo = "gnome-rounded-blur";
      rev = "v1.0.1";

      # First rebuild will fail and print the real hash.
      # Replace this with the printed `got: sha256-...`
      hash = "sha256-hiWQaYydlyIMHKsx49f7sGOLM9ev1g1kdlloUszZU8I";
    };

    nativeBuildInputs = with pkgs; [
      meson
      ninja
      pkg-config
      gobject-introspection
      wayland-scanner
      desktop-file-utils
      gettext
    ];

    buildInputs = with pkgs; [
      # Direct gnome-rounded-blur deps
      glib
      mutter

      # Mutter/pkg-config deps
      cairo
      colord
      lcms2
      pango
      libstartup_notification
      libcanberra
      libadwaita
      libxcvt
      libGL
      mesa-gl-headers

      # X11 deps
      libx11
      libxcomposite
      libxcursor
      libxdamage
      libxext
      libxfixes
      libxi
      libxcb
      libxrandr
      libxinerama
      libxau
      libsm

      # Wayland / input / compositor deps
      wayland
      wayland-protocols
      libinput
      libdrm
      libgbm
      libei
      libepoxy
      libdisplay-info
      libxkbcommon
      xkeyboard_config
      xwayland

      # GNOME / GTK deps
      gsettings-desktop-schemas
      gdk-pixbuf
      gnome-desktop
      gnome-settings-daemon
      gtk4
      atk
      fribidi
      harfbuzz
      graphene

      # Other Mutter deps
      pipewire
      libgudev
      libwacom
      sysprof
      libsysprof-capture
      libglycin
    ];

    postPatch = ''
      substituteInPlace meson.build \
        --replace-fail "mutter_api_version = '18'" "mutter_api_version = '${mutterApi}'" \
        --replace-fail "mutter_req = '>= 50.0'" "mutter_req = '>= ${mutterMajor}.0'" \
        --replace-fail "dependency('libmutter-18')" "dependency('libmutter-${mutterApi}')"
    '';
  };
in {
    environment.systemPackages = with pkgs; [
      gnomeExtensions.blur-my-shell
      gnomeRoundedBlur
    ];

    # Helps GNOME Shell/GJS find the custom Blur typelib.
    environment.sessionVariables = {
      GI_TYPELIB_PATH = "${gnomeRoundedBlur}/lib/girepository-1.0:${pkgs.mutter}/lib/girepository-1.0";
      LD_LIBRARY_PATH = "${gnomeRoundedBlur}/lib:${pkgs.mutter}/lib";
    };
  };
}
