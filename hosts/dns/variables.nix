{ ... }:
{
  flake.nixosModules.dns-variables =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      # Variables for dns host - extend as needed
      networking.hostName = "dns-server"; # Override the default hostname
    };
}
