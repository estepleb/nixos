{ self, ... }: {
  flake.nixosModules.fish = { lib, pkgs, ... }: {

    programs.fish.enable = true;

    environment.systemPackages = with pkgs; [
      zoxide
      bat
      fastfetch
      eza
      wget
    ];

    home-manager.users.${self.username} = {
      programs.fish = {
        enable = true;

        interactiveShellInit = ''
          # zoxide (replaces cd)
          zoxide init fish --cmd cd | source

          # Start SSH agent if not running
          if not pgrep -u "$USER" ssh-agent > /dev/null
            eval (ssh-agent -c) > /dev/null
          end

          # done plugin settings
          set -U __done_min_cmd_duration 10000
          set -U __done_notification_urgency_level low

          # man page formatting via bat
          set -x MANROFFOPT "-c"
          set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

          # Load ~/.fish_profile if present
          if test -f ~/.fish_profile
            source ~/.fish_profile
          end

          # Add ~/.local/bin to PATH
          if test -d ~/.local/bin
            if not contains -- ~/.local/bin $PATH
              set -p PATH ~/.local/bin
            end
          end

          # Add depot_tools to PATH
          if test -d ~/Applications/depot_tools
            if not contains -- ~/Applications/depot_tools $PATH
              set -p PATH ~/Applications/depot_tools
            end
          end

          # !! and !$ history expansion
          function __history_previous_command
            switch (commandline -t)
              case "!"
                commandline -t $history[1]; commandline -f repaint
              case "*"
                commandline -i !
            end
          end

          function __history_previous_command_arguments
            switch (commandline -t)
              case "!"
                commandline -t ""
                commandline -f history-token-search-backward
              case "*"
                commandline -i '$'
            end
          end

          if [ "$fish_key_bindings" = fish_vi_key_bindings ]
            bind -Minsert ! __history_previous_command
            bind -Minsert '$' __history_previous_command_arguments
          else
            bind ! __history_previous_command
            bind '$' __history_previous_command_arguments
          end
        '';

        functions = {
          fish_greeting = "fastfetch";

          history = "builtin history --show-time='%F %T '";

          backup = {
            argumentNames = [ "filename" ];
            body = "cp $filename $filename.bak";
          };

          copy = ''
            set count (count $argv | tr -d \n)
            if test "$count" = 2; and test -d "$argv[1]"
              set from (echo $argv[1] | string trim --right --chars=/)
              set to (echo $argv[2])
              command cp -r $from $to
            else
              command cp $argv
            end
          '';
        };

        shellAbbrs = {
          # General
          m     = "micro";
          cl    = "clear";
          e     = "exit";
          sl    = "ls";
          cp    = "cp -v";
          mv    = "mv -v";
          mkdir = "mkdir -p";

          # Git
          gco = "git checkout";
          gad = "git add";
          gst = "git status";
          gcm = "git commit -m";

          # Docker Compose
          dc   = "docker compose";
          dcu  = "docker compose up";
          dcd  = "docker compose down";
          dcr  = "docker compose restart";
          dcls = "docker compose ls";
          dcps = "docker compose ps";

          # Chezmoi
          ch   = "chezmoi";
          che  = "chezmoi edit";
          chea = "chezmoi edit --apply";
          chew = "chezmoi edit --watch";

          # Misc
          la = "ls -la";
          ll = "ls -l";
          nv = "nvim";

          # Nix
          nrs = "sudo nixos-rebuild switch --flake .#nix-vm";
          nrb = "sudo nixos-rebuild boot --flake .#nix-vm";
        };

        shellAliases = {
          # eza replaces ls
          ls   = "eza -al --color=always --group-directories-first --icons=always";
          la   = "eza -a --color=always --group-directories-first --icons=always";
          ll   = "eza -l --color=always --group-directories-first --icons=always";
          lt   = "eza -aT --color=always --group-directories-first --icons=always";
          "l." = "eza -a | grep -e '^\\.'";

          # bat replaces cat
          cat = "bat --theme=base16 --color=always --paging=never --tabs=2 --wrap=never --plain";
          bat = "bat --theme=base16 --color=always --paging=never --tabs=2 --wrap=never --plain";

          # System
          up      = "sudo nixos-rebuild switch --flake .#nix-vm";
          lsgrep  = "ls | grep";
          jctl    = "journalctl -p 3 -xb";
          psmem   = "ps auxf | sort -nr -k 4";
          psmem10 = "ps auxf | sort -nr -k 4 | head -10";

          # Navigation
          ".."     = "cd ..";
          "..."    = "cd ../..";
          "...."   = "cd ../../..";
          "....."  = "cd ../../../..";
          "......" = "cd ../../../../..";

          # Color overrides
          grep  = "grep --color=auto";
          fgrep = "fgrep --color=auto";
          egrep = "egrep --color=auto";
          dir   = "dir --color=auto";
          vdir  = "vdir --color=auto";

          # Utils
          tarnow = "tar -acf";
          untar  = "tar -zxvf";
          wget   = "wget -c";
        };
      };
    };
  };
}
