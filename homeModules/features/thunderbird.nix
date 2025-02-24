{ lib, config, ... }:
let
  cfg = config.myHome.thunderbird;
in
{
  options.myHome.thunderbird = {
    enable = lib.mkEnableOption "enable thunderbird";
  };
  config = lib.mkIf cfg.enable {
    # https://mynixos.com/home-manager/options/programs.thunderbird
    programs.thunderbird = {
      enable = true;
      profiles = { }; # Need to set atleast a "null" value
    };
  };
}
