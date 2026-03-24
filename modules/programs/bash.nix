{
  flake.nixosModules.bash = {
    home-manager.users.matthew.imports = [
    {
      programs.bash = {
        enable = true;
        bashrcExtra = ''
          PS1='\n\[\033[1;36m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\$\[\033[0m\] '
        '';
      };
    }
    ];
  };
}
