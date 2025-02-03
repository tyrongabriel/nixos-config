{ ... }:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm = {
    enable = true;
    # Set the GDM theme configuration
    settings = {

      "org/gnome/desktop/background" = {
        picture-uri = "../../wallpapers/minimalist-black-hole.png";
      };
    };
  };
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "at";
    variant = "nodeadkeys";
    options = "caps:escape";
  };
}
