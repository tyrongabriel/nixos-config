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
        "org/gnome/desktop/lockdown" = {
          disable-log-out = false;
          disable-user-switching = false;
          disable-lock-screen = false;
          disable-command-line = false;
          disable-application-switching = false;
        };

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
            #lock-keys.extensionUuid
            dash-to-dock.extensionUuid
            # Alternatively, you can manually pass UUID as a string.
            #"blur-my-shell@aunetx"
            # ...
          ];
          always-show-log-out = true;
        };

        "org/gnome/desktop/interface" = {
          icon-theme = "Adwaita";
        };

        "org/gnome/shell/extensions/lock-keys" = {
          dock-fixed = true;
        };

        # Caps/Numlock buttons
        # "org/gnome/shell/extensions/lock-keys" = {
        #   show-power-off = true;
        #   show-restart = true;
        # };

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
      lock-keys
      dash-to-dock
    ];

    # Catppuccin icon/styling
    gtk = lib.mkDefault {
      enable = true;
      theme = {
        name = "Catppuccin-Mocha-Blue"; # Example name, adjust to your liking.
        package = pkgs.catppuccin-gtk.override {
          accents = [ "blue" ];
          variant = "mocha";
        };
      };
    };

    # Set profile Picture
    home.file.".face".source = ./../../images/catppuccin-pfp.png;
    # Copy that to GDM
    # systemd.user.services."gdm-profile-picture" = {
    #   Unit = {
    #     Description = "Set user profile picture using chfn";
    #     WantedBy = [ "graphical-session.target" ];
    #     After = [ "graphical-session.target" ];
    #   };
    #   Service = {
    #     Type = "oneshot";
    #     ExecStart = ''
    #       chfn -f "$(getent passwd ${config.home.username} | cut -d: -f5 | cut -d, -f1)" -p "${config.home.homeDirectory}/.face" ${config.home.username}
    #     '';
    #   };

    # };
  };
}
