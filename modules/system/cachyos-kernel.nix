{ inputs, ... }: {
  flake.nixosModules.cachyos-kernel = { config, lib, pkgs, ... }: {
    # Overlay to add CachyOS kernel packages
    nixpkgs.overlays = [
      inputs.nix-cachyos-kernel.overlays.default
    ];
    
    # Add binary cache for faster downloads of pre-built kernels
    nix.settings.substituters = [
      "https://attic.xuyh0120.win/lantian"
    ];
    nix.settings.trusted-public-keys = [
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
    ];

    # Documentation for available kernel packages
    # 
    # Available kernel packages (use as: boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-*):
    # Latest kernel variants:
    # - linuxPackages-cachyos-latest
    # - linuxPackages-cachyos-latest-x86_64-v3
    # - linuxPackages-cachyos-latest-x86_64-v4
    # - linuxPackages-cachyos-latest-zen4
    # - linuxPackages-cachyos-latest-lto
    # - linuxPackages-cachyos-latest-lto-x86_64-v3
    # - linuxPackages-cachyos-latest-lto-x86_64-v4
    # - linuxPackages-cachyos-latest-lto-zen4
    #
    # LTS kernel variants:
    # - linuxPackages-cachyos-lts
    # - linuxPackages-cachyos-lts-x86_64-v3
    # - linuxPackages-cachyos-lts-x86_64-v4
    # - linuxPackages-cachyos-lts-zen4
    # - linuxPackages-cachyos-lts-lto
    # - linuxPackages-cachyos-lts-lto-x86_64-v3
    # - linuxPackages-cachyos-lts-lto-x86_64-v4
    # - linuxPackages-cachyos-lts-lto-zen4
    #
    # BORE scheduler variants:
    # - linuxPackages-cachyos-bore
    # - linuxPackages-cachyos-bore-x86_64-v3
    # - linuxPackages-cachyos-bore-x86_64-v4
    # - linuxPackages-cachyos-bore-zen4
    # - linuxPackages-cachyos-bore-lto
    # - linuxPackages-cachyos-bore-lto-x86_64-v3
    # - linuxPackages-cachyos-bore-lto-x86_64-v4
    # - linuxPackages-cachyos-bore-lto-zen4
    #
    # Other variants:
    # - linuxPackages-cachyos-bmq, -linuxPackages-cachyos-bmq-lto
    # - linuxPackages-cachyos-deckify, -linuxPackages-cachyos-deckify-lto
    # - linuxPackages-cachyos-eevdf, -linuxPackages-cachyos-eevdf-lto
    # - linuxPackages-cachyos-hardened, -linuxPackages-cachyos-hardened-lto
    # - linuxPackages-cachyos-rc, -linuxPackages-cachyos-rc-lto
    # - linuxPackages-cachyos-rt-bore, -linuxPackages-cachyos-rt-bore-lto
    # - linuxPackages-cachyos-server, -linuxPackages-cachyos-server-lto
  };
}
