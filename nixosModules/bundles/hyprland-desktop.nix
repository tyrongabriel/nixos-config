{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.bundles.hyprland-desktop;
in
{
  options.myNixOS.bundles.hyprland-desktop = {
    enable = lib.mkEnableOption "Enable Hyprland Desktop";
  };

  config = lib.mkIf cfg.enable {
    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    programs.hyprland.enable = true;
    programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    programs.hyprland.portalPackage =
      inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    myNixOS = {
      sddm.enable = lib.mkDefault true;
    };
  };
}
