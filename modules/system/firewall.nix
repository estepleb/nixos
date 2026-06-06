{ ... }:
{
  flake.nixosModules.firewall =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      networking.firewall = {
        enable = true;
        allowedTCPPorts = [
          22
          80
          443
        ];
        allowedUDPPorts = [ 443 ];
      };
    };
}
