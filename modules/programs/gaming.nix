{
  flake.nixosModules.gaming = { pkgs, ... }:
  {
    programs.steam.enable = true;
    programs.gamescope.enable = true;
  };
}
