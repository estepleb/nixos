{ self, ... }:
{
  flake = rec {
    hostname = "nix-vm";
    username = "estepleb";
    tailnet = "bullhead-komodo.ts.net";
    homeDir = "/home/" + username;

    configDir = homeDir + "/.config/nixos";

    keyboardLayout = "us";
    location = "Washington DC";
    timeZone = "America/New_York";
    defaultLocale = "en_US.UTF-8";
    extraLocale = "en_US.UTF-8";

    git = {
      username = "estepleb";
      email = "tallis.estevez1@gmail.com";
    };

    autoUpgrade = true;
    autoGarbageCollector = true;

    hardware = {
      gpuVendor = "intel";
    };
  };
}
