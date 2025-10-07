{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.myHome.bundles.gaming;
in
{
  options.myHome.bundles.gaming = {
    enable = lib.mkEnableOption "Enable Gaming Bundle";
  };

  config = lib.mkIf cfg.enable {
    #programs.steam = {
    #  enable = true;
    #  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    #  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    #  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    #};
    programs.mangohud.enable = true;
    home.packages = with pkgs; [
      #lutris
      steam
      steam-run
      protonup-ng
      gamemode
      dxvk
      # parsec-bin

      gamescope

      # heroic
      mangohud

      #r2modman

      heroic

      #er-patcher
      bottles

      steamtinkerlaunch
    ];
  };
}
