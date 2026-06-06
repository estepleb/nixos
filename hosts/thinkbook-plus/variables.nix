{ ... }: {
  flake.nixosModules.thinkbook-plus-variables = { config, lib, pkgs, ... }: {
    # Variables for thinkbook-plus host - extend as needed
    networking.hostName = "thinkbook-plus";  # Override the default hostname
  };
}