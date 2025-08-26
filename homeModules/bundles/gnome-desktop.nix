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
    home.file = {
      ".face".source = config.myHome.profilePicture;
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
        "org/gnome/login-screen" = {
          # Need to turn path to a string for dconf!
          logo = "${config.myHome.profilePicture}";
        };

        "org/gnome/desktop/lockdown" = {
          disable-log-out = false;
          disable-user-switching = false;
          disable-lock-screen = false;
          disable-command-line = false;
          disable-application-switching = false;
        };

        "org/gnome/shell" = {
          favorite-apps = [
            "com.mitchellh.ghostty.desktop"
            "dev.zed.Zed.desktop"
            "brave-browser.desktop"
            "discord.desktop"
            "thunderbird.desktop"
            "code.desktop"
            "org.gnome.Nautilus.desktop"
          ];
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
            #dash-to-dock.extensionUuid
            dash-to-panel.extensionUuid
            # Alternatively, you can manually pass UUID as a string.
            #"blur-my-shell@aunetx"
            # ...
            user-themes.extensionUuid
            arcmenu.extensionUuid
            vitals.extensionUuid
            clipboard-indicator.extensionUuid
            rounded-window-corners-reborn.extensionUuid
            #openweather-refined.extensionUuid
            #battery-health-charging.extensionUuid
            #gsconnect.extensionUuid
            bluetooth-battery-meter.extensionUuid
            #just-perfection.extensionUuid
            media-controls.extensionUuid

            tailscale-qs.extensionUuid
            wireguard-vpn-extension.extensionUuid
          ];
          always-show-log-out = true;
        };

        "org/gnome/shell/extensions/vitals" = {
          hide-icons = false;
          hide-zeros = false;
          hot-sensors = [ "_battery_time_left_" ];
          icon-style = 1;
          menu-centered = false;
          position-in-panel = 2;
          show-battery = true;
          show-fan = false;
          show-temperature = false;
          show-memory = false;
          show-processor = false;
          show-network = false;
          show-system = false;
          update-time = 10;
          use-higher-precision = true;
        };

        "org/gnome/shell/extensions/dash-to-panel" = {
          hot-keys = false; # Disable Super+num for dock apps
          animate-appicon-hover = true;
          animate-appicon-hover-animation-extent = builtins.toJSON {
            RIPPLE = 4;
            PLANK = 4;
            SIMPLE = 1;
          };
          appicon-margin = 4;
          appicon-padding = 7;
          appicon-style = "NORMAL";
          dot-position = "BOTTOM";
          group-apps = true;
          hide-overview-on-startup = true;
          hotkeys-overlay-combo = "TEMPORARILY";
          intellihide = true;
          intellihide-hide-from-windows = true;
          isolate-workspaces = false;
          leftbox-padding = -1;
          leftbox-size = 0;
          overview-click-to-exit = false;
          panel-anchors = builtins.toJSON { "0" = "MIDDLE"; };
          panel-element-positions = builtins.toJSON {
            "0" = [
              {
                element = "showAppsButton";
                visible = false;
                position = "stackedTL";
              }
              {
                element = "activitiesButton";
                visible = true;
                position = "stackedTL";
              }
              {
                element = "leftBox";
                visible = true;
                position = "stackedTL";
              }
              {
                element = "taskbar";
                visible = true;
                position = "stackedTL";
              }
              {
                element = "centerBox";
                visible = true;
                position = "stackedBR";
              }
              {
                element = "rightBox";
                visible = true;
                position = "stackedBR";
              }
              {
                element = "dateMenu";
                visible = true;
                position = "stackedBR";
              }
              {
                element = "systemMenu";
                visible = true;
                position = "stackedBR";
              }
              {
                element = "desktopButton";
                visible = true;
                position = "stackedBR";
              }
            ];
          };
          panel-lengths = builtins.toJSON { "0" = 100; };
          panel-positions = builtins.toJSON { "0" = "BOTTOM"; };
          panel-sizes = builtins.toJSON { "0" = 48; };
          primary-monitor = 0;
          progress-show-count = true;
          secondarymenu-contains-appmenu = true;
          secondarymenu-contains-showdetails = false;
          show-showdesktop-hover = false;
          status-icon-padding = -1;
          stockgs-force-hotcorner = false;
          stockgs-keep-dash = false;
          stockgs-keep-top-panel = true;
          stockgs-panelbtn-click-only = false;
          trans-use-custom-bg = false;
          trans-use-custom-opacity = true;
          tray-padding = 6;
          tray-size = 0;
          window-preview-title-position = "TOP";
        };

        "org/gnome/shell/extensions/arcmenu" = {
          button-padding = -1;
          dash-to-panel-standalone = false;
          disable-recently-installed-apps = false;
          hide-overview-on-startup = false;
          menu-layout = "Whisker";
          multi-monitor = true;
          pinned-apps = builtins.toJSON [
            { id = "firefox.desktop"; }
            { id = "org.gnome.Nautilus.desktop"; }
            { id = "org.gnome.Terminal.desktop"; }
            {
              id = "gnome-extensions prefs arcmenu@arcmenu.com";
              name = "ArcMenu Settings";
              icon = "ArcMenu_ArcMenuIcon";
            }
            { id = "bitwarden.desktop"; }
            { id = "bitwarden.desktop"; }
          ];
          pop-folders-data = builtins.toJSON {
            "Library Home" = "Library Home";
            "Utilities" = "Utilities";
          };
          prefs-visible-page = 0;
          runner-hotkey = [ "<Super>r" ];
          search-entry-border-radius = builtins.toJSON [
            true
            25
          ];
          show-activities-button = false;
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
      arcmenu # Better app menu
      vitals # System vitals (Battery time etc.)
      clipboard-indicator # Clipboard history
      rounded-window-corners-reborn
      #openweather-refined
      #battery-health-charging
      #gsconnect # KDE Connect for GNOME
      bluetooth-battery-meter
      dash-to-panel
      just-perfection
      media-controls
      # VPN's
      tailscale-qs
      wireguard-vpn-extension
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
