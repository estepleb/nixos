{ self, ... }:
{
  flake.nixosModules.gamedev = { pkgs, ... }: {
    imports = [
      self.nixosModules.neovim
      self.nixosModules.tmux
      self.nixosModules.git
    ];

    environment.systemPackages = with pkgs; [
      # aseprite
      dotnet-sdk
      godot-mono
      obs-studio
      # wine
      wineWow64Packages.stable
      winetricks
    ];
  };
}
