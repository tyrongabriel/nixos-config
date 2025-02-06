{ config, lib, ... }:
let
  cfg = config.myHome.nh;
in
{
  options.myHome.nh = {
    enable = lib.mkEnableOption "Enable nh command util";
  };

  config = lib.mkIf cfg.enable {
    programs.nh = {
      enable = true;
      #clean.enable = true;
      #clean.extraArgs = "--keep-since 4d --keep 3";
      # Configured in home.nix homeDirectory
      flake = "/home/tyron/nixos-config";
    };
  };
}
