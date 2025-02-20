{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.myHome.bundles.gnome-desktop;
in
{
  options.myHome.bundles.gnome-desktop = {
    enable = lib.mkEnableOption "Enable GNOME Desktop customization";
  };

  config = lib.mkIf cfg.enable {
    # https://determinate.systems/posts/declarative-gnome-configuration-with-nixos/
    # https://wiki.nixos.org/wiki/GNOME
    dconf = {
      enable = true; # Dconf is the config database

      # Configure params
      settings = {
        "org/gnome/shell" = {
          disable-user-extensions = false; # enables user extensions
          enabled-extensions = with pkgs.gnomeExtensions; [
            # Put UUIDs of extensions that you want to enable here.
            # If the extension you want to enable is packaged in nixpkgs,
            # you can easily get its UUID by accessing its extensionUuid
            # field (look at the following example).
            appindicator.extensionUuid
            blur-my-shell.extensionUuid
            #status-icons.extensionUuid
            space-bar.extensionUuid
            window-is-ready-remover.extensionUuid
            # Alternatively, you can manually pass UUID as a string.
            #"blur-my-shell@aunetx"
            # ...
          ];
        };

        # Configure individual extensions
        "org/gnome/shell/extensions/blur-my-shell" = {
          brightness = 0.35;
          noise-amount = 0;
        };

        "org/gnome/desktop/wm/preferences" = {
          button-layout = "appmenu:minimize,maximize,close";
        };
      };

    };

    # Add the extension packages here
    home.packages = with pkgs.gnomeExtensions; [
      # ...
      blur-my-shell
      #status-icons
      space-bar
      window-is-ready-remover
      appindicator
    ];
  };
}
