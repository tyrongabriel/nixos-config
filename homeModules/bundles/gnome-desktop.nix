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
    autostartPrograms = lib.mkOption {
      description = "A list of program packages with names to autostart.";
      type =
        with pkgs.lib.types;
        listOf (submodule {
          options = {
            pkg = lib.mkOption {
              type = package;
              description = "Package to be launched";
            };
            name = lib.mkOption {
              type = str;
              description = "Name of the .desktop file inside of the package ({pkg}/share/appliactions/{name}.desktop)";
            };
            extraArguments = lib.mkOption {
              type = listOf str;
              description = "List of extra configuration to the .desktop file";
              default = [ ];
            };
            replaceArguments = lib.mkOption {
              type = listOf (submodule {
                options = {
                  from = lib.mkOption {
                    description = "String to be replaced with the 'to' attribute";
                    type = str;
                  };
                  to = lib.mkOption {
                    description = "String to replace the 'from' attribute";
                    type = str;
                  };
                };
              });
              description = "List of configuration to be replaced in the .desktop file";
              default = [ ];
            };
          };
        });
      default = [ ];
    };
  };

  config = lib.mkIf cfg.enable {
    # Autostart apps
    # https://github.com/nix-community/home-manager/issues/3447
    home.file =
      {
        ".face".source = ./../../images/catppuccin-pfp.png;
      }
      // builtins.listToAttrs (
        map (
          pkg:
          let
            # Read file content, concat the extra args
            textContent =
              (
                if pkg.pkg ? dekstopItem then
                  pkg.pkg.desktopItem.text
                else
                  builtins.readFile (pkg.pkg + "/share/applications/" + pkg.name + ".desktop")
              )
              + (builtins.concatStringsSep "\n" pkg.extraArguments);
            replaceFroms = builtins.map (ra: ra.from) pkg.replaceArguments;
            replaceTos = builtins.map (ra: ra.to) pkg.replaceArguments;
          in
          {
            name = ".config/autostart/" + pkg.name + ".desktop";
            value = {
              # Replace the replace-args in the textContent
              text = (builtins.replaceStrings replaceFroms replaceTos textContent);
            };
          }
        ) cfg.autostartPrograms
      );

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
            user-themes.extensionUuid
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
      user-themes
    ];

    # Catppuccin gtk styling
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
    #home.file.".face".source = ./../../images/catppuccin-pfp.png;
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
