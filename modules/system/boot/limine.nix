{ ... }:
{
  flake.nixosModules.limine =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      boot.loader = {
        timeout = 1;
        efi.canTouchEfiVariables = true;
      };

      # Using Limine bootloader
      boot.loader.systemd-boot.enable = false;
      boot.loader.grub = {
        enable = true;
        efiSupport = true;
        devices = [ "nodev" ];
      };
    };
}
