{ lib, config, ... }:
let
  cfg = config.myNixOS.docker;
  userName = config.myNixOS.userName;
in
{
  options.myNixOS.docker = with lib; {
    enable = mkEnableOption "Enable docker virtualization";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.docker.enable = true;
    users.users.${userName}.extraGroups = [ "docker" ];
  };
}
