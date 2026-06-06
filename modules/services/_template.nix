{ self, ... }:
{
  flake.nixosModules.NAME =
    { config, pkgs, ... }:
    let
      service = "";
      prettyName = "";
      hostname = ""; # Overrides service as hostname
      description = "";
      category = "";
      icon = ".png";
      port = 8000;

      # Logic
      resolvedHost = if hostname != "" then hostname else service;
      domain = self.tailnet;
      fqdn = "${resolvedHost}.${domain}";
    in
    {
      sops.secrets.${service} = {
        sopsFile = "${self.secretsPath}/secrets.yaml";
        mode = "0400";
      };

      services.homepage-dashboard.services = [
        {
          "${category}" = [
            {
              "${prettyName}" = {
                icon = "${icon}";
                description = "${description}";
                href = "https://${fqdn}";
              };
            }
          ];
        }
      ];

      services.caddy.virtualHosts."${fqdn}" = {
        extraConfig = ''
          bind tailscale/{resolvedHost}
          encode zstd gzip
          reverse_proxy 127.0.0.1:${toString port}
        '';
      };
    };
}
