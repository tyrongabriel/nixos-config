{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myHome.openconnect;
in
{
  options.myHome.openconnect = with lib; {
    enable = mkEnableOption "Enable Openconnect for VPN's";
  };

  config = lib.mkIf cfg.enable {
    # TuVPN: openconnect --user eXXXXXXXX@student.tuwien.ac.at vpn.tuwien.ac.at
    home.packages = with pkgs; [
      openconnect
    ];

  };
}
