{ self, ... }: {
  flake.nixosModules.syncthing = 
  { config, lib, pkgs, ... }:
  let
    service       = "syncthing";
    prettyName    = "Syncthing";
    hostname      = ""; # Overrides service as hostname
    description   = "E2EE File sync";
    category      = "Utilities";
    icon          = "syncthing.png";
    port          = 8384;

    # Logic
    resolvedHost  = if hostname != "" then hostname else service;
    domain        = self.tailnet;
    fqdn          = "${resolvedHost}.${domain}";
  in
  {
    config = {
      services.caddy.virtualHosts."${fqdn}" = {
        extraConfig = ''
          bind tailscale/syncthing
          reverse_proxy 127.0.0.1:${toString port}
        '';
      };
  
      services.homepage-dashboard.services = [
        {
          "Utilities" = [
            {
              "Syncthing" = {
                icon = "${icon}";
                description = "${description}";
                href = "https://${fqdn}";
              };
            }
          ];
        }
      ];
    
      services.syncthing = {
        enable = true;
        openDefaultPorts = true;
        user = self.username;
        dataDir = "/home/${self.username}";
        extraFlags = [ ];
  
        # Stable device ID across rebuilds - requires sops secrets
        # key = config.sops.secrets.syncthing-key.path;
        # cert = config.sops.secrets.syncthing-cert.path;
  
        settings = {
          gui = {
            address = "127.0.0.1:${toString port}";
            insecureSkipHostcheck = true;
            extraOptions.insecureAllowedHostnames = [ fqdn ];
            # Uncomment to add credentials
            # user = "myuser";
            # password = "mypassword";
          };
  
          devices = {
            # Add devices here after pairing, or to pre-authorize them
            # "device1" = { id = "DEVICE-ID-GOES-HERE"; };
            # "device2" = { id = "DEVICE-ID-GOES-HERE"; };
          };
  
          folders = {
            # Basic folder synced with multiple devices
            # "Documents" = {
            #   path = "/home/${config.var.username}/Documents";
            #   devices = [ "device1" "device2" ];
            # };
  
            # Folder with permission syncing enabled
            # "Example" = {
            #   path = "/home/${config.var.username}/Example";
            #   devices = [ "device1" ];
            #   ignorePerms = false;
            # };
  
            # Folder with encrypted sync to an untrusted device
            # "Sensitive" = {
            #   path = "/home/${config.var.username}/Sensitive";
            #   devices = [
            #     "device1"  # trusted, gets decrypted contents
            #     {
            #       name = "device2";  # untrusted, gets encrypted copy
            #       encryptionPasswordFile = config.sops.secrets.syncthing-encryption-password.path;
            #     }
            #   ];
            # };
          };
        };
      };
    };
  };
}
