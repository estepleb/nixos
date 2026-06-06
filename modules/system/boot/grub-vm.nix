{ ... }: {
  flake.nixosModules."grub-vm" = { config, lib, pkgs, ... }: {
    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
    boot.loader.efi.canTouchEfiVariables = true;
  };
}