{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
let
  cfg = config.myNixOS.winapps;
  system = pkgs.system;
  userName = config.myNixOS.userName;
in
{
  options.myNixOS.winapps = with lib; {
    enable = mkEnableOption "Enable Windows applications";
  };

  config = lib.mkIf cfg.enable {
    # set up binary cache (optional)
    nix.settings = {
      substituters = [ "https://winapps.cachix.org/" ];
      trusted-public-keys = [ "winapps.cachix.org-1:HI82jWrXZsQRar/PChgIx1unmuEsiQMQq+zt05CD36g=" ];
    };

    environment.systemPackages = with inputs.winapps.packages."${system}"; [
      winapps
      winapps-launcher # optional
    ];

    # Enable docker for winapps virtualziation
    myNixOS.docker.enable = true;
    # Docker compose file will be placed if home-manager config is active
  };
}
