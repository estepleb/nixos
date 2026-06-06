{ ... }: {
  flake.nixosModules."grub-vm" = { config, lib, pkgs, ... }: {
    boot.loader.grub = {
      enable = true;
      device = "/dev/sdb";
      useOSProber = true;
    };
  };
}
