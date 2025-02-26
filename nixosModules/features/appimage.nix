{ lib, config, ... }:
let
  cfg = config.myNixOS.appimage;
in
{
  options.myNixOS.appimage = {
    enable = lib.mkEnableOption "Enable appimage-run to run AppImages";
  };

  config = lib.mkIf cfg.enable {
    programs.appimage = {
      enable = true;
      binfmt = true;
    };
  };

}
