{ lib, config, ... }:
let
  cfg = config.myHome.temux;
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
