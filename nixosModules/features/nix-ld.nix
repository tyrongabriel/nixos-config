{ lib, config, ... }:
let
  cfg = config.myNixOS.nix-ld;
in
{
  options.myNixOS.nix-ld = {
    enable = lib.mkEnableOption "Enable Nix LD for unpatched binaries";
  };

  config = lib.mkIf cfg.enable {
    programs.nix-ld = {
      enable = true;
    };
  };

}
