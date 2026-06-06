{ self, ... }:
{
  flake.nixosModules.utils-desktop =
    {
      pkgs,
      lib,
      ...
    }:
    let
      keyboardLayout = self.keyboardLayout;
    in
    {
      services = {
        xserver = {
          enable = false;
          xkb.layout = keyboardLayout;
          xkb.variant = "";
        };
        gnome.gnome-keyring.enable = true;
        psd = {
          enable = true;
          resyncTimer = "10m";
        };
        libinput.enable = true;
        dbus = {
          enable = true;
          implementation = "broker";
          packages = with pkgs; [
            gcr
            gnome-settings-daemon
          ];
        };
        gvfs.enable = true;
        upower.enable = true;
        power-profiles-daemon.enable = true;
        udisks2.enable = true;
      };

      programs.dconf.enable = true;

      environment.variables = {
        TERMINAL = "foot";
        TERM = "foot";
        BROWSER = "zen-browser";
      };

      xdg.portal = {
        enable = true;
        xdgOpenUsePortal = true;
        config = {
          common.default = [ "gtk" ];
          hyprland.default = [
            "gtk"
            "hyprland"
          ];
          mango.default = lib.mkForce [
            "wlroots"
            "gtk"
          ];
        };
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      };
    };
}
