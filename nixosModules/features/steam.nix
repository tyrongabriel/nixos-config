{ lib, config, ... }:
let
  cfg = config.myNixOS.steam;
in
{
  options.myNixOS.steam = {
    enable = lib.mkEnableOption "Enable Steam";
  };
  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
  };
}
