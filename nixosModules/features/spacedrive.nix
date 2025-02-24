{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.spacedrive;
in
{
  options.myNixOS.spacedrive = {
    enable = lib.mkEnableOption "Enable SDDM";
  };

  config = lib.mkIf cfg.enable {
    # https://github.com/spacedriveapp/spacedrive
    environment.systemPackages = with pkgs; [
      spacedrive
    ];

  };
}
