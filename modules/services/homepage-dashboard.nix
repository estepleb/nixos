{ self, ... }:
{
  flake.nixosModules."homepage-dashboard" =
    {
      config,
      pkgs,
      ...
    }:
    let
      service = "homepage";
      prettyName = "Homepage";
      hostname = ""; # Overrides service as hostname
      port = 8082;

      # Logic
      resolvedHost = if hostname != "" then hostname else service;
      domain = self.tailnet;
      fqdn = "${resolvedHost}.${domain}";
    in
    {
      # sops.secrets.homepage-dashboard-env = {
      #   sopsFile = "${self.secretsPath}/secrets.yaml";
      #   format = "yaml";
      #   owner = config.services.homepage-dashboard.user;
      #   group = config.services.homepage-dashboard.group;
      #   mode = "0400";
      # };

      virtualisation.oci-containers.containers.socket-proxy = {
        image = "lscr.io/linuxserver/socket-proxy:latest";
        ports = [ "127.0.0.1:2375:2375" ];
        environment = {
          ALLOW_START = "0";
          ALLOW_STOP = "0";
          ALLOW_RESTARTS = "0";
          AUTH = "0";
          BUILD = "0";
          COMMIT = "0";
          CONFIGS = "0";
          CONTAINERS = "1"; # Allow access to viewing containers
          DISABLE_IPV6 = "0";
          DISTRIBUTION = "0";
          EVENTS = "1";
          EXEC = "0";
          IMAGES = "0";
          INFO = "1";
          LOG_LEVEL = "info";
          NETWORKS = "0";
          NODES = "0";
          PING = "1";
          PLUGINS = "0";
          POST = "0"; # Disallow any POST operations (effectively read-only)
          SECRETS = "0";
          SERVICES = "1"; # Allow access to viewing services (necessary when using Docker Swarm)
          SESSION = "0";
          SWARM = "0";
          SYSTEM = "0";
          TASKS = "1"; # Allow access to viewing tasks (necessary when using Docker Swarm)
          TZ = self.timeZone;
          VERSION = "1";
          VOLUMES = "0";
        };
        volumes = [
          "/var/run/docker.sock:/var/run/docker.sock:ro"
        ];
        extraOptions = [
          "--read-only"
          "--tmpfs=/run"
          "--health-cmd=nc -z localhost 2375 || exit 1"
          "--health-interval=10s"
          "--health-timeout=3s"
          "--health-retries=3"
          "--health-start-period=5s"
        ];
      };

      services.caddy.virtualHosts."${fqdn}" = {
        extraConfig = ''
          bind tailscale/${resolvedHost}
          encode zstd gzip
          reverse_proxy 127.0.0.1:${toString port}
        '';
      };

      services.homepage-dashboard = {
        enable = true;
        package = pkgs.homepage-dashboard;
        allowedHosts = "localhost:${toString port},127.0.0.1:${toString port},${fqdn}";
        settings = {
          # providers = {
          #   openweathermap = "openweathermapapikey";
          #   weatherapi = "weatherapiapikey";
          #   paperlessngx = {
          #     key = "";
          #   };
          #   arcane = {
          #     key = "";
          #   };
          #   kopia = {
          #     username = "";
          #     password = "";
          #   };
          # };
        };
        bookmarks = [
          {
            Developer = [
              {
                Github = [
                  {
                    abbr = "GH";
                    href = "https://github.com/";
                  }
                ];
              }
              {
                Tailscale = [
                  {
                    abbr = "TS";
                    href = "https://login.tailscale.com/admin/machines";
                  }
                ];
              }
            ];
          }
          {
            Social = [
              {
                Reddit = [
                  {
                    abbr = "RE";
                    href = "https://reddit.com/";
                  }
                ];
              }
            ];
          }
          {
            Entertainment = [
              {
                YouTube = [
                  {
                    abbr = "YT";
                    href = "https://youtube.com/";
                  }
                ];
              }
            ];
          }
        ];
        services = [
          {
            "Utilities" = [
              {
                "Proxmox" = {
                  icon = "proxmox.png";
                  href = "https://proxmox.${domain}";
                  description = "Lenovo m90q Proxmox";
                };
              }
              {
                "Adguard" = {
                  icon = "adguard-home.png";
                  href = "https://adguard.${domain}";
                  description = "DNS Filter";
                };
              }
            ];
          }
        ];
        widgets = [
          {
            resources = {
              cpu = true;
              disk = "/";
              memory = true;
            };
          }
          {
            search = {
              provider = "duckduckgo";
              target = "_blank";
            };
          }
        ];
        kubernetes = { };
        # proxmox = {
        #   pve = {
        #     url = "https://proxmox.${domain.tailnet}";
        #     token = "username@pam!Token ID";
        #     secret = "secret";
        #   };
        # };
        docker = {
          my-docker = {
            host = "127.0.0.1";
            port = 2375;
          };
        };
        customJS = "";
        customCSS = "";
      };
    };
}
