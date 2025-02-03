# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  ...
}:

{
  imports = [
    # Include the system specific configurations (Boot, hardware etc.)
    ./system
    ../../nixosModules
  ];

  options = { };

  config = {
    myNixos = {
      # Enable xremap
      xremap.enable = true;
      xremap.remaps = {
        "Capslock" = "Esc";
      };
    };

    networking.hostName = "yoga"; # Define your hostname.
    #networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.

    # Enable networking
    networking.networkmanager.enable = true;

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

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.tyron = {
      isNormalUser = true;
      description = "Tyron Gabriel";
      initialPassword = "12345";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];

      shell = pkgs.zsh; # Default shell
    };
    programs.zsh.enable = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      nixd # Nix Language Server
      nil
      nixfmt-rfc-style
      neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      git
      gcc
      libinput
      obsidian
      vscode
      nh
      zsh
    ];

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?

  };
}
