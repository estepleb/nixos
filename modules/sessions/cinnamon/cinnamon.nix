{ self, ... }:
{
  flake.nixosModules.cinnamon =
    { pkgs, ... }:
    {
      services.xserver.desktopManager.cinnamon.enable = true;
      services.xserver.displayManager.lightdm.enable = true;
      services.xserver.enable = true;
      services.power-profiles-daemon.enable = false;
      # services.gnome.gnome-online-accounts.enable = true;

      environment.systemPackages = with pkgs; [
        # Convert dconf configs to Nix-compatable format.
        # To convert your current configuration, run the following command:
        # `dconf dump /org/cinnamon/ | dconf2nix --root org/cinnamon > ~/.nixos/modules/sessions/cinnamon/dconf.nix.temp`
        dconf2nix
      ];

      environment.sessionVariables = {
        MOZ_USE_XINPUT2 = 1; # Fix Firefox-based browsers scroll on X11.
      };

      home-manager.users.${self.username}.imports = [
        self.homeModules.cinnamon-dconf # Define dconf options.
      ];
    };
}
