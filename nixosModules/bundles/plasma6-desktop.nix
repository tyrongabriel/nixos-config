{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.bundles.plasma6-desktop;
in
{
  options.myNixOS.bundles.plasma6-desktop = with lib; {
    enable = mkEnableOption "Enable plasma6 desktop environment";
  };

  config = lib.mkIf cfg.enable {
    services.xserver.enable = lib.mkDefault true;
    #services.displayManager.sddm.enable = lib.mkDefault true; # Later also configured in the sddm config
    services.desktopManager.plasma6.enable = lib.mkDefault true;
    myNixOS.sddm.enable = true;

    # Fixes/Guide from the nixos.wiki/wiki/KDE
    # Pulseaudio needs to be enabled!
    #hardware.pulseaudio.enable = lib.mkForce true;
    # Themes way not be applied for GTK, fix:
    programs.dconf.enable = lib.mkDefault true;
    # Mail blank message render
    environment.sessionVariables = {
      NIX_PROFILES = "${pkgs.lib.concatStringsSep " " (
        pkgs.lib.reverseList config.environment.profiles
      )}";
    };
    # Force launch in wayland (should be default anyways) instaed of plasmax11
    services.displayManager.defaultSession = "plasma";

    # Remove plasma6 default apps
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      #  plasma-browser-integration
      konsole
      #  oxygen
    ];

    environment.systemPackages = with pkgs; [
      xdg-utils # Required for desktop integration
      xdg-user-dirs # Required for XDG directories
      gtk3 # In case some GTK applications are used
      qt5.qttools # QT5 Tools
      qt6.qtbase # QT6 Base (for Plasma 6)
    ];
  };
}
