{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.klee;
in
{
  options.myNixOS.klee = with lib; {
    enable = mkEnableOption "Enable KLEE Symbolic vm";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      klee
    ];
  };
}
