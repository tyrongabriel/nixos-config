{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myHome.bundles.general;
in
{
  options.myHome.bundles.general = with lib; {
    enable = mkEnableOption "Enable General Bundle";
  };

  config = lib.mkIf cfg.enable {
    myHome = {
      ghostty.enable = lib.mkDefault true;
    };

    home.packages = with pkgs; [
      bottom

    ];
  };
}
