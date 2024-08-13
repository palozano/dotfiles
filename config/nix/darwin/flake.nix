# After installing Nix in the mac(hine), run: `nix run nix-darwin -- switch --flake .`
# This allows to run `darwin-rebuild switch --flake .` anytime now.
#
# To update the system, you need two commands:
# `nix flake update --commit-lock-file`
# `darwin-rebuild switch --flake .`

{
  description = "Portable Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    hostname = "palozano16";
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs;
        [ 
          git 
          wezterm
          neovim 
          fzf 
          ripgrep

          direnv
          age
          atac
          termshark
        ];

      services = {
        nix-daemon.enable = true;
        # yabai = {
        #   enable = true;
        #   config = {
        #     focus_follows_mouse = "autoraise";
        #     mouse_follows_focus = "off";
        #     window_placement    = "second_child";
        #     window_opacity      = "off";
        #     top_padding         = 36;
        #     bottom_padding      = 10;
        #     left_padding        = 10;
        #     right_padding       = 10;
        #     window_gap          = 10;
        #   };
        #   extraConfig = '''';
        # }
      };

      # nix.package = pkgs.nix;
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs = {
        zsh = {
          enable = true;
          enableCompletion = true;
          enableFzfCompletion = true;
          enableFzfHistory = true;
          enableSyntaxHighlighting = true;
          # ohMyZsh = {
          #   enable = true;
          #   plugins = [ 
          #     "git" 
          #     "zsh-autosuggestions" 
          #     "zsh-syntax-highlighting"
          #     "zsh-fzf-history-search"
          #     "fzf-tab"
          #     #"you-should-use"
          #     #{
          #     #  name = "you-should-use";
          #     #  src = pkgs.fetchFromGitHub {
          #     #    owner = "MichaelAquilina";
          #     #    repo = "zsh-you-should-use";
          #     #    rev = "1.8.0";
          #     #    sha256 = "/8e0548c0c2270c3ee422f350106e538d108c3f5b";
          #     #  };
          #     #}
          #   ];
          #};
        };

        tmux = {
          enable = true;
          enableMouse = true;
          enableSensible = true;
          enableFzf = true;
          enableVim = true;
          extraConfig = ''
            set -ag terminal-overrides ",xterm*:Tc"

            unbind C-b
            set -g prefix C-Space
            bind C-Space send-prefix

            set-option -g status-right ""

            # dont clear selection
            set -g @yank_action 'copy-pipe-no-clear'

            # avoid ESC delay
            set -s escape-time 0

            # set scroll history to 100.000 lines
            set-option -g history-limit 100000

            # Use Ctrl-arrow or Alt-arrow keys to resize panes
            bind-key -r -T prefix  M-Up    resize-pane -U 5
            bind-key -r -T prefix  M-Down  resize-pane -D 5
            bind-key -r -T prefix  M-Left  resize-pane -L 5
            bind-key -r -T prefix  M-Right resize-pane -R 5
            bind-key -r -T prefix  C-Up    resize-pane -U
            bind-key -r -T prefix  C-Down  resize-pane -D
            bind-key -r -T prefix  C-Left  resize-pane -L
            bind-key -r -T prefix  C-Right resize-pane -R

            # Synchronize panes
            bind -n C-s setw synchronize-panes on
            bind -n M-s setw synchronize-panes off

            # Open a pop up in the middle
            bind -n M-g display-popup -E "tmux new-session -A -c ~/ -s scratch"
          '';
        };
      };

      homebrew = {
        brews = [
          # `brew install`
          "imagemagick"
          "docker"

          # `brew install --with-rmtp`, `brew services restart` on version changes
          # {
          #   name = "denji/nginx/nginx-full";
          #   args = [ "with-rmtp" ];
          #   restart_service = "changed";
          # }
          #
          # `brew install`, always `brew services restart`, `brew link`, `brew unlink mysql` (if it is installed)
          # {
          #   name = "mysql@5.6";
          #   restart_service = true;
          #   link = true;
          #   conflicts_with = [ "mysql" ];
          # }
        ];

        casks = [
          # `brew install --cask`
          #"google-chrome"

          # `brew install --cask --appdir=~/my-apps/Applications`
          {
            name = "firefox";
            args = { appdir = "~/my-apps/Applications"; };
            greedy = true; # always upgrade auto-updated or unversioned cask to latest version even if already installed
          }
        ];
      };

      system = {
        configurationRevision = self.rev or self.dirtyRev or null;
        stateVersion = 4;
        defaults = {
          dock.autohide = true;
          dock.mru-spaces = false;
          finder.AppleShowAllExtensions = true;
          finder.FXPreferredViewStyle = "clmv";
          # loginwindow.LoginwindowText = "Pablo";
          screencapture.location = "~/Desktop/screenshots";
          screensaver.askForPasswordDelay = 10;
        };
      };

      # Enable sudo with Touch ID authentication
      security.pam.enableSudoTouchIdAuth = true;

      # You can run Intel binaries with Rosetta. Install it with a CLI 
      #     `softwareupdate --install-rosetta --agree-to-license`.
      # And the add this to the config:
      #nix.extraOptions = ''
      #  extra-platforms = x86_64-darwin aarch64-darwin
      #'';

      # You can also do this for GNU/Linux systems too:
      #nix.linux-builder.enable = true;
      


      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations.${hostname}.pkgs;
  };
}
