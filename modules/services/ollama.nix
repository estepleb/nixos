{ self, ... }: {
  flake.nixosModules.ollama = 
  { config, lib, pkgs, ... }:
  let
    service       = "open-webui";
    prettyName    = "Open WebUI";
    hostname      = ""; # Overrides service as hostname
    description   = "Ollama Local AI Frontend";
    category      = "Utilities";
    icon          = "open-webui.png";
    openWebUiPort = 8083;
    ollamaPort = 11434;

    ollamaUrl = "http://127.0.0.1:${toString ollamaPort}";

    # Logic
    resolvedHost  = if hostname != "" then hostname else service;
    domain        = self.tailnet;
    fqdn          = "${resolvedHost}.${domain}";
  in
  {
      environment.systemPackages = with pkgs; [ ollama open-webui ];
  
      services = {
        ollama = {
          package = pkgs.ollama-vulkan;
          enable = true;
          host = "127.0.0.1";
          port = ollamaPort;
          loadModels = [ 
          "llama3.2:3b" 
          "deepseek-r1:1.5b" 
          "MedAIBase/PaddleOCR-VL:0.9b" 
          "qwen3.5" 
          "gemma4" 
          ];
        };
        open-webui = {
          enable = true;
          port = openWebUiPort;
          environment = {
            ANONYMIZED_TELEMETRY = "False";
            DO_NOT_TRACK = "True";
            SCARF_NO_ANALYTICS = "True";
            OLLAMA_API_BASE_URL = ollamaUrl;
            WEBUI_AUTH = "False";
          };
        };
        caddy.virtualHosts."${fqdn}" = {
          extraConfig = ''
            bind tailscale/${resolvedHost}
            reverse_proxy 127.0.0.1:${toString openWebUiPort}
          '';
        };
      };
    };
  }
