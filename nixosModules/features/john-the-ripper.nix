{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.john-the-ripper;
in
{
  options.myNixOS.john-the-ripper = with lib; {
    enable = mkEnableOption "Enable John the Ripper Password cracker";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      john
    ];
  };
}
