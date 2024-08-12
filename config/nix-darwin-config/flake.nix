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
      environment.systemPackages = with.pkgs;
        [ 
          git neovim wget curl neofetch fzf ripgrep
        ];

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        enableFzfCOmpletion = true;
        enableFzfHistory = true;
        enableSyntaxHighlighting = true;
        oh-my-zsh = {
          enable = true;
          plugins = [ 
            "git" 
            # "tmux" 
            "zsh-autosuggestions" 
            "zsh-syntax-highlighting"
            {
              name = "you-should-use";
              src = pkgs.fetchFromGitHub {
                owner = "MichaelAquilina";
                repo = "zsh-you-should-use";
                rev = "1.8.0";
                sha256 = "/8e0548c0c2270c3ee422f350106e538d108c3f5b";
              };
            }
          ];
        };
      };

      programs.tmux = {
        enable = true;
        enableMouse = true;
        enableSensible = true;
        enableFzf = true;
        enableVim = true;
        extraConfig = '''';
      };

      system = {
        configurationRevision = self.rev or self.dirtyRev or null;
        stateVersion = 4;
        defaults = {
          dock.autohide = true;
          dock.mru-spaces = false;
          finder.AppleShowAllExtensions = true;
          # finder.FXPreferredViewStyle = "clmv";
          # loginwindow.LoginwindowText = "Pablo";
          screencapture.location = "~/Desktop/screenshots";
          screensaver.askForPasswordDelay = 10;
        };
      };

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
    darwinPackages = self.darwinConfigurations..${hostname}.pkgs;
  };
}
