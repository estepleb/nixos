{
  flake.nixosModules.tmux = { pkgs, ... }: {
    home-manager.users.matthew.imports = [
    {
      programs.tmux = {
        enable = true;
        mouse = true;
        baseIndex = 1;
        plugins = with pkgs; [
          {
            plugin = tmuxPlugins.resurrect;
            extraConfig = "set -g @resurrect-strategy-nvim 'session'";
          }
        ];
        extraConfig = ''
          unbind -a -T root
          bind -n M-r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded"

          bind -n M-s choose-session

          bind -n M-1 select-window -t 1
          bind -n M-2 select-window -t 2
          bind -n M-3 select-window -t 3
          bind -n M-4 select-window -t 4
          bind -n M-5 select-window -t 5
          bind -n M-6 select-window -t 6
          bind -n M-7 select-window -t 7
          bind -n M-8 select-window -t 8
          bind -n M-9 select-window -t 9

          bind -n M-h select-pane -L
          bind -n M-l select-pane -R
          bind -n M-k select-pane -U
          bind -n M-j select-pane -D

          bind -n M-H resize-pane -L 5
          bind -n M-L resize-pane -R 5
          bind -n M-K resize-pane -U 3
          bind -n M-J resize-pane -D 3

          bind -n M-u split-window -v
          bind -n M-i split-window -h

          bind -n M-t new-window
          bind -n M-c kill-pane
          bind -n M-q kill-window
          bind -n M-w kill-session
          bind -n M-d detach
        '';
      };
    }
    ];
  };
}
