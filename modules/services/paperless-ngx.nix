{ self, ... }: {
  flake.nixosModules.paperless-ngx = { config, lib, pkgs, ... }: 
    let
      service       = "paperless-ngx";
      prettyName    = "Paperless-ngx";
      hostname      = "paperless"; # Overrides service as hostname
      description   = "Document archive";
      category      = "Personal";
      icon          = "paperless-ngx.png";
      port          = 8087;

      # Logic
      resolvedHost  = if hostname != "" then hostname else service;
      domain        = self.tailnet;
      fqdn          = "${resolvedHost}.${domain}";
    in
    {
      config = {
        users.users.paperless = {
          isSystemUser = true;
          group = "paperless";
          description = "Paperless-ngx service account";
          shell = pkgs.shadow;
          createHome = true;
          home = "/var/lib/paperless";
        };
        users.groups.paperless = {};
        users.users.${self.username}.extraGroups = [ "paperless" ];
    
        sops.secrets.paperless-admin-password = {
          sopsFile = "${self.secretsPath}/secrets.yaml";
          owner = "paperless";
        };
    
        
        services.caddy.virtualHosts."${domain}" = {
          extraConfig = ''
            bind tailscale/${resolvedHost}
            encode zstd gzip
            reverse_proxy 127.0.0.1:${toString port}
          '';
        };
    
    
        services.homepage-dashboard.services = [
          {
            "Personal" = [
              {
                "Paperless-ngx" = {
                  icon = "${icon}";
                  description = "${description}";
                  href = "https:/${fqdn}";
                };
              }
            ];
          }
        ];
    
        
        services.paperless = {
          enable = true;
          address = "127.0.0.1";
          port = port;
          user = "paperless";
          dataDir = "/var/lib/paperless";
          mediaDir = "/var/lib/paperless/media";
          consumptionDir = "/var/lib/paperless/consume";
          consumptionDirIsPublic = true;
          database.createLocally = true;
          passwordFile = config.sops.secrets.paperless-admin-password.path;
    
          settings = {
            PAPERLESS_URL = "https://${fqdn}";
            PAPERLESS_TIME_ZONE = self.timeZone;
            PAPERLESS_UMASK = "0027";
    
            # OCR
            PAPERLESS_OCR_LANGUAGE = "eng";
            PAPERLESS_OCR_USER_ARGS = ''{"continue_on_soft_render_error": true}'';
    
            # Consumer
            PAPERLESS_CONSUMER_RECURSIVE = true;
            PAPERLESS_CONSUMER_SUBDIRS_AS_TAGS = true;
            PAPERLESS_CONSUMER_DELETE_DUPLICATES = true;
    
            # Filename format
            PAPERLESS_FILENAME_FORMAT = "{{ created_year }}/{{ correspondent }}/{{ document_type }}/{{ title }}";
            PAPERLESS_FILENAME_FORMAT_REMOVE_NONE = false;
    
            # Tika/Gotenberg for Office document support
            PAPERLESS_TIKA_ENABLED = true;
            PAPERLESS_TIKA_ENDPOINT = "http://localhost:9998";
            PAPERLESS_TIKA_GOTENBERG_ENDPOINT = "http://localhost:3000";
          };
        };
    
        # Wait for data dir before starting services
        systemd.services.paperless-scheduler.after = [ "var-lib-paperless.mount" ];
        systemd.services.paperless-consumer.after = [ "var-lib-paperless.mount" ];
        systemd.services.paperless-web.after = [ "var-lib-paperless.mount" ];
    
        # Tika for Office document parsing
        virtualisation.oci-containers.containers.tika = {
          image = "docker.io/apache/tika:latest";
          ports = [ "127.0.0.1:9998:9998" ];
        };
    
        # Gotenberg for PDF rendering
        virtualisation.oci-containers.containers.gotenberg = {
          image = "docker.io/gotenberg/gotenberg:8.25";
          ports = [ "127.0.0.1:3000:3000" ];
          cmd = [
            "gotenberg"
            "--chromium-disable-javascript=true"
            "--chromium-allow-list=file:///tmp/.*"
          ];
        };
    
        systemd.tmpfiles.rules = [
          "d /var/lib/paperless              0750 paperless paperless -"
          "d /var/lib/paperless/consume      0750 paperless paperless -"
          "d /var/lib/paperless/export       0750 paperless paperless -"
          "d /var/lib/paperless/media        0750 paperless paperless -"
          "d /var/lib/paperless/media/documents 0750 paperless paperless -"
          "Z /var/lib/paperless              -    paperless paperless -"
        ];
      };
    };
}
