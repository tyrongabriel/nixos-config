# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./system
  ];
  # Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Custom Config Location
  nix.nixPath = [
    "nix-config=~/nixos-config"
    "nixpkgs=${inputs.nixpkgs}"
  ];

  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
    ];
    dates = "daily";
    randomizedDelaySec = "45min";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = false; # Default Bootloader
  #boot.loader.efi.canTouchEfiVariables = true;
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      # assuming /boot is the mount point of the  EFI partition in NixOS (as the installation section recommends).
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      device = "nodev"; # No specific partition
      useOSProber = true; # Autodetect windows
      # despite what the configuration.nix manpage seems to indicate,
      # as of release 17.09, setting device to "nodev" will still call
      # `grub-install` if efiSupport is true
      # (the devices list is not used by the EFI grub install,
      # but must be set to some value in order to pass an assert in grub.nix)
      #devices = [ "nodev" ];
      efiSupport = true;
      #enable = true;
      # Breeze Grub theme
      #extraConfig = ''
      #  GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
      #'';
      gfxmodeEfi = "1920x1200x32";
      #gfxpayloadEfi = "keep";
      font = "${pkgs.fira-code}/share/fonts/truetype/FiraCode-VF.ttf";
      fontSize = 26;

      theme = (
        pkgs.catppuccin-grub.override {
          flavor = "mocha";
        }
      );
      splashImage = null;
      timeoutStyle = "menu";

    };

    # Hide os choice -> shows when pressing button
    timeout = 1;
  };

  # Enable plymouth for smooth startup animation
  boot = {
    initrd.availableKernelModules = [
      "amdgpu"
      "simpledrm"
    ];
    plymouth = {
      enable = true;
      theme = "catppuccin-mocha";
      themePackages = with pkgs; [
        (catppuccin-plymouth.override {
          variant = "mocha";
        })
        # By default we would install all themes wiki.nixos.org/wiki/Plymouth
        #(adi1090x-plymouth-themes.override {
        #  selected_themes = [ "rings" ];
        #})
      ];

      extraConfig = ''
        ShowDelay=0
      '';

    };

    # Enable silent booting
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "vga=current"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "plymouth.use-simpledrm"
      "vt.global_cursor_default=0"
      "fbcon=nodefer"
    ];
  };
  hardware.graphics.enable = true; # For plymouth to render instantly
  time.hardwareClockInLocalTime = true; # For time format in windows dualboot

  networking.hostName = "yoga"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_AT.UTF-8";
    LC_IDENTIFICATION = "de_AT.UTF-8";
    LC_MEASUREMENT = "de_AT.UTF-8";
    LC_MONETARY = "de_AT.UTF-8";
    LC_NAME = "de_AT.UTF-8";
    LC_NUMERIC = "de_AT.UTF-8";
    LC_PAPER = "de_AT.UTF-8";
    LC_TELEPHONE = "de_AT.UTF-8";
    LC_TIME = "de_AT.UTF-8";
  };

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
  hardware.pulseaudio.enable = false;
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
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  # Install firefox.
  #programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nixd # Nix Language Server
    nil
    nixfmt-rfc-style
    zsh
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    brave
    discord
    bitwarden
    synergy
    htop
    tmux
    curl
    wget
    git
    gcc
    vlc
    fzf
    ripgrep
    ncdu
    nmap
    libinput
    obsidian
    mullvad-vpn
    vscode
    jetbrains.idea-ultimate
    jdk21
    nh
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/tyron/nixos-config";
  };

  # XRemap
  services.xremap = {
    # NOTE: since this sample configuration does not have any DE, xremap needs to be started manually by systemctl --user start xremap
    serviceMode = "user";
    userName = "tyron";
  };
  # Modmap for single key rebinds
  services.xremap.config.modmap = [
    {
      name = "Global";
      remap = {
        "CapsLock" = "Esc";
      }; # globally remap CapsLock to Esc
    }
  ];

  # Lid Closing
  #services.logind = {
  # enable = true;
  # lidSwitch = "poweroff"; # Options: ignore, suspend, hibernate, poweroff
  # lidSwitchDocked = "suspend";
  #};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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

}
