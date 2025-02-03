{
  config,
  lib,
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

    };
  };
}
