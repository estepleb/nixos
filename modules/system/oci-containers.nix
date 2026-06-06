{ ... }:
{
  flake.nixosModules."oci-containers" =
    { config, ... }:
    {
      virtualisation.oci-containers = {
        backend = "podman";
      };

      virtualisation.containers.containersConf.settings = {
        network.firewall_driver = "nftables";
      };
    };
}
