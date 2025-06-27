{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.bundles.gnome-desktop;
in
{
  options.myNixOS.bundles.gnome-desktop = {
    enable = lib.mkEnableOption "Enable GNOME Desktop";
  };

  config = lib.mkIf cfg.enable {
    # Follow
    # https://hoverbear.org/blog/declarative-gnome-configuration-in-nixos/#getting-home-manager-set-up

    services.xserver.enable = true;
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
    environment.gnome.excludePackages = (
      with pkgs;
      [
        gnome-photos
        gnome-tour
        gnome-music
        cheese # webcam tool
        gedit # text editor
        epiphany # web browser
        geary # email reader
        gnome-characters
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
        yelp # Help view
        gnome-contacts
        gnome-initial-setup
      ]
    );
    # ++ (with pkgs.gnome; [ ] );
    programs.dconf.enable = true;
    # GDM Profile picture
    services.accounts-daemon.enable = true;
    environment.systemPackages = with pkgs; [
      gnome-tweaks
      dconf-editor
    ];

    # QT styling not available for gnome platform
    stylix.targets = lib.mkIf config.myNixOS.stylix.enable {
      qt.enable = false;
    };
  };
}
