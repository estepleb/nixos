{ self, inputs, ... }:
{
  flake.nixosModules.mac-style-plymouth =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [ inputs.mac-style-plymouth.overlays.default ];

      boot.plymouth = {
        enable = true;
        theme = "mac-style";
        themePackages = [ pkgs.mac-style-plymouth ];
      };
    };
}
