{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.wireguard;
in
{
  options.myNixOS.wireguard = with lib; {
    enable = mkEnableOption "Enable WireGuard";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wireguard-go
    ];
  };
}
