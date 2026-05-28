{ self, ... }:
{
  flake.nixosModules.gamedev = { pkgs, ... }: {
    imports = [
      self.nixosModules.tmux
      self.nixosModules.git
    ];

    environment.systemPackages = with pkgs; [
      # (pkgs.bottles.override {removeWarningPopup = true; })
      # aseprite
      audacity
      davinci-resolve
      dotnet-sdk
      godot-mono
      handbrake
      obs-studio
      video-trimmer
    ];
  };
}
