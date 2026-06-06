{ ... }: {
  flake.nixosModules.git-variables = { config, lib, pkgs, ... }: {
    options.var.git = {
      username = lib.mkOption {
        type = lib.types.str;
        default = "Esteve Pleban";
        description = "Git username";
      };
      email = lib.mkOption {
        type = lib.types.str;
        default = "esteve.pleban@example.com";
        description = "Git email";
      };
    };
  };
}