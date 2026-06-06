{ self, ... }: {
  flake.nixosModules.utils = {
    pkgs,
    lib,
    ...
  }: let
    hostname = self.hostname;
    keyboardLayout = self.keyboardLayout;
    configDir = self.configDir;
    timeZone = self.timeZone;
    defaultLocale = self.defaultLocale;
    extraLocale = self.extraLocale;
    autoUpgrade = self.autoUpgrade;
  in {
    networking.hostName = hostname;
    networking.networkmanager.enable = true;
    systemd.services.NetworkManager-wait-online.enable = false;

    system.autoUpgrade = {
      enable = autoUpgrade;
      dates = "04:00";
      flake = "${configDir}";
      flags = [ "--update-input" "nixpkgs" "--commit-lock-file" ];
      allowReboot = false;
    };

    time.timeZone = timeZone;
    i18n.defaultLocale = defaultLocale;
    i18n.extraLocaleSettings = {
      LC_ADDRESS        = extraLocale;
      LC_IDENTIFICATION = extraLocale;
      LC_MEASUREMENT    = extraLocale;
      LC_MONETARY       = extraLocale;
      LC_NAME           = extraLocale;
      LC_NUMERIC        = extraLocale;
      LC_PAPER          = extraLocale;
      LC_TELEPHONE      = extraLocale;
      LC_TIME           = extraLocale;
    };

    console.keyMap = keyboardLayout;

    environment.variables = {
      XDG_DATA_HOME        = "$HOME/.local/share";
      PASSWORD_STORE_DIR   = "$HOME/.local/share/password-store";
      EDITOR               = "micro";
    };

    # Faster rebuilding
    documentation = {
      enable    = true;
      doc.enable    = false;
      man.enable    = true;
      dev.enable    = false;
      info.enable   = false;
      nixos.enable  = false;
    };

    security = {
      rtkit.enable = true;
      sudo.wheelNeedsPassword = false;
    };

    environment.systemPackages = with pkgs; [
      fd
      bc
      gcc
      file
      git-ignore
      xdg-utils
      wget
      curl
      vim
      micro
      git
      killall
      htop
      btop
      unzip
      zip
      jq
      yq-go
      ripgrep
      dig
      cachix
      nix-output-monitor
      nurl
      comma
      nh
      nix-inspect
      nix-tree
      nix-init
      nix-update
      nixfmt
      nil
      alejandra
    ];
  };
}
