{ config, lib, ... }:
let
  cfg = config.myHome.btop;
in
{
  options.myHome.btop = {
    enable = lib.mkEnableOption "Enable btop";
  };

  config = lib.mkIf cfg.enable {
    programs.btop = {
      enable = true;
      settings = {
        vim_keys = true;
      };
    };
  };
}
