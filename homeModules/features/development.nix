{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.myHome.development;
in
{
  options.myHome.development = with lib; {
    enable = mkEnableOption "Enable Development tools";
  };

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      silent = true;
      nix-direnv = {
        enable = true;
      };
    };

    home.packages = with pkgs; [
      #insomnia
      bruno
      lnav
    ];

    programs.zsh = {
      # Add hook
      # initContent = ''
      #   eval "$(direnv hook zsh)"
      # '';
      #oh-my-zsh.plugins = [ "direnv" ];

    };
  };
}
