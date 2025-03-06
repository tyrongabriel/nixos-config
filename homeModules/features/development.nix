{ lib, config, ... }:
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
    };

    programs.zsh = {
      # Add hook
      initExtra = ''
        eval "$(direnv hook zsh)"
      '';
      oh-my-zsh.plugins = [ "direnv" ];

    };
  };
}
