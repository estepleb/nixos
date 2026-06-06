{ self, ... }:
{
  flake.nixosModules.gnome =
    { pkgs, ... }:
    {
      imports = [ self.nixosModules.blur-my-shell ];
      services.displayManager.gdm.enable = true;
      services.desktopManager.gnome.enable = true;
      services.power-profiles-daemon.enable = false;
      services.flatpak.enable = true;

      environment.systemPackages = with pkgs; [
        gnome-software
        gnome-tweaks
        gnomeExtensions.arc-menu
        # gnomeExtensions.blur-my-shell
        gnomeExtensions.dash-to-panel
        gnomeExtensions.just-perfection
      ];
    };
}
