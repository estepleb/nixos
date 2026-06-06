{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];
  perSystem =
    { pkgs, ... }:
    {
      treefmt = {
        projectRootFile = "flake.nix";
        programs.nixfmt.enable = true;
        programs.nixfmt.package = pkgs.nixfmt;
        programs.shellcheck.enable = true;
        settings.formatter.shellcheck.options = [
          "-s"
          "bash"
        ];
      };
    };
}
