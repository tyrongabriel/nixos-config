{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.devenv;
in
{
  options.myNixOS.devenv = with lib; {
    enable = mkEnableOption "Enable devenv dev environments";
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      devenv
    ];

    nix.settings.trusted-users = [
      "root"
      "tyron"
    ];

    # nix.extraOptions = ''
    #   extra-substituters = https://devenv.cachix.org
    #   extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
    # '';
  };
}
