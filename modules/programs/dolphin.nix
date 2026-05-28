{ inputs, ... }:
{
  flake.nixosModules.dolphin = { pkgs , ... }: {
    # nixpkgs.overlays = [ inputs.dolphin-overlay.overlays.default ];

    xdg.menus.enable = true;
    xdg.mime.enable = true;

    environment.systemPackages = with pkgs; [
      kdePackages.dolphin
      kdePackages.qtsvg
      kdePackages.kio # needed since 25.11
      kdePackages.kio-fuse # to mount remote filesystems via FUSE
      kdePackages.kio-extras # extra protocols support (sftp, fish and more)
    ];
  };
}
