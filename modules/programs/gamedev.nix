{ self, ... }:
{
  flake.nixosModules.gamedev = { pkgs, ... }: {
    imports = [
      self.nixosModules.nvf
      self.nixosModules.tmux
      self.nixosModules.git
    ];

    environment.systemPackages = with pkgs; [
      # aseprite
      # (pkgs.bottles.override {removeWarningPopup = true; })
      audacity
      dotnet-sdk
      godot-mono
      handbrake
      obs-studio
      video-trimmer
    ];
  };
}
