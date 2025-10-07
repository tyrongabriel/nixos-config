{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.myHome.zsh;
in
{
  options.myHome.zsh = with lib; {
    enable = mkEnableOption "Enable Zsh";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      eza
      exiftool
      bat
      chafa
    ];

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.eza = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.zsh = {
      enable = lib.mkDefault true;
      enableCompletion = lib.mkDefault true;
      autosuggestion.enable = lib.mkDefault true;
      #initExtra = "neofetch";
      ## Content at the very end:
      initContent = mkAfter ''
        unalias gcd 2>/dev/null
      '';
      shellAliases = {
        ll = "eza -lag --icons";
        llt = "eza -lag --icons --tree --level 2"; # Specify --level to limit depth
        lah = "eza -lahg --icons";
        fzfb = "fzf --preview='bat --color=always {}'";
        cd = "z";
        k = "kubectl";
      };
      syntaxHighlighting.enable = lib.mkDefault true;
      oh-my-zsh = {
        enable = lib.mkDefault true;
        theme = "lambda";
        plugins = [
          "git"
          "cp" # Progress bar cp
          #"zoxide"
          #"zsh"
          #"fzf-zsh-plugin"
        ];
      };

      # nix-prefetch-github <owner> <repo>
      plugins = [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.8.0";
            sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
          };
        }
        {
          name = "zsh-syntax-highlighting";
          file = "catppuccin_mocha-zsh-syntax-highlighting.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "zsh-syntax-highlighting";
            rev = "7926c3d3e17d26b3779851a2255b95ee650bd928";
            hash = "sha256-l6tztApzYpQ2/CiKuLBf8vI2imM6vPJuFdNDSEi7T/o=";
          };
        }
        # {
        #   name = "fzf-zsh-plugin";
        #   file = "fzf-zsh-plugin.plugin.zsh";
        #   src = pkgs.fetchFromGitHub {
        #     owner = "unixorn";
        #     repo = "fzf-zsh-plugin";
        #     rev = "909f0b8879481eab93741fa284a7d1d13cf6f79e";
        #     hash = "sha256-RILk4dHYk6yL7wmdRqmOf6JsyyoKNbbT6dHa5ExAAP0=";
        #   };
        # }
      ];

    };
  };
}
