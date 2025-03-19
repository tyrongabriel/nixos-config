{ lib, config, ... }:
let
  cfg = config.myHome.tmux;
in
{
  options.myHome.tmux = {
    enable = lib.mkEnableOption "Enable Tmux";
  };

  config = lib.mkIf cfg.enable {
    programs.tmux = {
      enable = true;
    };
  };
}
