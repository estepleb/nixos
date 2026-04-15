{ self, ... }:
{
  flake.nixosModules.base = { pkgs, ... }: {
    imports = [
      self.nixosModules.vpn
      self.nixosModules.zen-browser
    ];

    # List packages installed in system profile.
    environment.systemPackages = with pkgs; [
      gnome-clocks
      kdePackages.okular
      kdePackages.partitionmanager
      krita
      obsidian
      telegram-desktop
      vesktop
    ];

    # List font packages installed in system profile.
    fonts.packages = with pkgs; [
      ibm-plex
      nerd-fonts.jetbrains-mono
    ];
  };

  flake = {
    user = "matthew";
  };
}
