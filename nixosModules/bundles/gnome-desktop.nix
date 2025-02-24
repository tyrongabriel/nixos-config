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
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    # environment.gnome.excludePackages =
    #   (with pkgs; [
    #     gnome-photos
    #     gnome-tour
    #   ])
    #   ++ (with pkgs.gnome; [
    #     cheese # webcam tool
    #     gnome-music
    #     gedit # text editor
    #     epiphany # web browser
    #     geary # email reader
    #     gnome-characters
    #     tali # poker game
    #     iagno # go game
    #     hitori # sudoku game
    #     atomix # puzzle game
    #     yelp # Help view
    #     gnome-contacts
    #     gnome-initial-setup
    #   ]);
    programs.dconf.enable = true;
    # GDM Profile picture
    services.accounts-daemon.enable = true;
    environment.systemPackages = with pkgs; [
      gnome-tweaks
    ];
  };
}
