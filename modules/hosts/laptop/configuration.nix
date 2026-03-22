# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, self, ... }:
{
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.nixosModules.laptop ];
  };

  flake.nixosModules.laptop = { pkgs, ... }: {

    # Import NixOS modules.
    imports = [
      self.nixosModules.fastfetch
      self.nixosModules.gamedev
      self.nixosModules.gaming
      self.nixosModules.home-manager
      self.nixosModules.kitty
      self.nixosModules.niri
      self.nixosModules.zen-browser
    ];

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Enable flakes.
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Enable store optimization on every rebuild.
    nix.settings.auto-optimise-store = true;

    # Enable automatic garbace collection.
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    networking.hostName = "nixos"; # Define your hostname.

    # Configure network connections interactively with nmcli or nmtui.
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Asia/Almaty";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable bluetooth.
    hardware.bluetooth.enable = true;

    # Enable sound.
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };

    # Enable TLP.
    services.tlp = {
      enable = true;
      settings = {
        # Improve performance on battery.
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_performance";
        PLATFORM_PROFILE_ON_BAT = "performance";
      };
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.matthew = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
        tree
      ];
    };

    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile.
    # You can use https://search.nixos.org/ to find more packages (and options).
    environment.systemPackages = with pkgs; [
      gnome-clocks
      kdePackages.okular
      krita
      obsidian
      telegram-desktop
      vesktop
    ];

    # List font packages installed in system profile.
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];

    fileSystems = {
      "/".options = [ "compress=zstd" ];
      "/home".options = [ "compress=zstd" ];
      "/nix".options = [ "compress=zstd" "noatime" ];
    };

    # Mount /dev/nvme0n1p5 data partition.
    fileSystems."/mnt/data" = {
      device = "/dev/disk/by-uuid/a7614c0a-f5ee-4eab-a431-853affce8a34";
      fsType = "btrfs";
      options = [
        "users"
        "nofail"
        "exec"
      ];
    };

    system.stateVersion = "25.11"; # Did you read the comment?
  };
}

