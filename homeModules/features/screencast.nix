{ config, lib, ... }:
let
  cfg = config.myHome.screencast;
in
with lib;
{
  options.myHome.screencast = {
    enable = mkEnableOption "Screencasting via Miracast and chromecast";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gnome-network-displays
      mkchromecast
      # You'll likely need ffmpeg for transcoding
      ffmpeg
      # And maybe pyqt5 for the system tray GUI
      # pyqt5
    ];
  };
}
