{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myHome.zsh;
in
{
  options.myHome.zsh = with lib; {
    enable = mkEnableOption "Enable Zsh";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = lib.mkDefault true;
      enableCompletion = lib.mkDefault true;
      autosuggestion.enable = lib.mkDefault true;
      #initExtra = "neofetch";
      initExtra = "unalias gcd 2>/dev/null";
      shellAliases = {
        ll = "ls -la";
        lah = "ls -lah";

      };
      syntaxHighlighting.enable = lib.mkDefault true;
      oh-my-zsh = {
        enable = lib.mkDefault true;
        theme = "lambda";
        plugins = [
          "git"
          "cp" # Progress bar cp
        ];
      };

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
          # nix-prefetch-github
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "zsh-syntax-highlighting";
            rev = "7926c3d3e17d26b3779851a2255b95ee650bd928";
            hash = "sha256-l6tztApzYpQ2/CiKuLBf8vI2imM6vPJuFdNDSEi7T/o=";
          };
        }
      ];

    };
  };
}
