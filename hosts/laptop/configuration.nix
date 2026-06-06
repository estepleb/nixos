# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ self, inputs, ... }:
{
  flake.nixosModules.laptop = { pkgs, ... }: {

    # Import NixOS modules.
    imports = [
      self.nixosModules.laptopHardware

      self.nixosModules.base
      self.nixosModules.gamedev
      self.nixosModules.gaming

      self.nixosModules.fastfetch
      self.nixosModules.home-manager

      # self.nixosModules.cinnamon
      # self.nixosModules.gnome
      # self.nixosModules.hyprland
      self.nixosModules.niri
      # self.nixosModules.plasma
    ];

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.timeout = 1;

    # Use latest kernel.
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Use the GRUB EFI boot loader.
    # boot.loader = {
    #   grub = {
    #     enable = true;
    #     device = "nodev"; # "nodev" is used for UEFI
    #     efiSupport = true;
    #     useOSProber = true;
    #   };
    #   efi.canTouchEfiVariables = true;
    # };

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

    # Enable OpenCL support.
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = 
      let
        pkgs = import inputs.nixpkgs-c5ae371f1 {
          system = "x86_64-linux";
          config.allowUnfree = true;
        }; 
      in 
      [ 
        pkgs.intel-compute-runtime-legacy1 # Use the latest driver commit that worked with DaVinci Resolve.
      ];
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${self.user} = {
      isNormalUser = true;
      extraGroups = [ "wheel" "input" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
        tree
      ];
    };
  
    # Allow unfree packages.
    nixpkgs.config.allowUnfree = true;

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

