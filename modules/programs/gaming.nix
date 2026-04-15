{
  flake.nixosModules.gaming = { pkgs, ... }:
  {
    environment.systemPackages = with pkgs; [
      prismlauncher
    ];

    programs.steam.enable = true;
    programs.gamescope.enable = true;
  };
}
