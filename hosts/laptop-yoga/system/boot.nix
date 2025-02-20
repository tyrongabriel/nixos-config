{
  pkgs,
  lib,
  config,
  ...
}:
{
  # Bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      # assuming /boot is the mount point of the  EFI partition in NixOS (as the installation section recommends).
      #efiSysMountPoint = "/boot/efi";
    };
    grub = lib.mkForce {
      # To override stylix to get a prettier bootloader
      enable = true;
      device = "nodev"; # No specific partition
      useOSProber = true; # Autodetect windows
      efiSupport = true;
      gfxmodeEfi = "2880x1800x32";

      font = "${config.stylix.fonts.monospace.package}/share/fonts/truetype/NerdFonts/JetBrainsMono/JetBrainsMonoNerdFontMono-Regular.ttf";
      # "${pkgs.fira-code}/share/fonts/truetype/FiraCode-VF.ttf";
      fontSize = 26;

      # Catppuccin Theme
      theme = (
        pkgs.catppuccin-grub.override {
          flavor = "mocha";
        }
      );
      splashImage = null;
      timeoutStyle = "hidden";

    };
    systemd-boot = {
      enable = false;
      consoleMode = "max";
    };
    # Hide os choice -> shows when pressing button
    timeout = 0;
  };

  # Enable plymouth for smooth startup animation
  boot = {
    initrd.availableKernelModules = [
      "amdgpu"
      "simpledrm"
    ];
    plymouth = lib.mkDefault {
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
        Logo=
      '';
    };

    # Enable silent booting
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "profile"
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      #"plymouth.use-simpledrm"
      #"vt.global_cursor_default=0"
      #"fbcon=nodefer"
      #"vga=current"
      # nixos.wiki/wiki/Hibernation
      "resume_offset=25532416" # gotten through sudo filefrag -v /var/lib/swapfile | awk 'NR==4{gsub(/\./,"");print $4;}'
    ];

    resumeDevice = "/dev/disk/by-uuid/ae97e642-8478-4b62-a7f5-cdd41d197ad1";
  };
  hardware.graphics.enable = true; # For plymouth to render instantly

  # Hibernation
  powerManagement.enable = true;

  # Lid behaviour
  services.logind = {
    extraConfig = ''
      HandlePowerKey=poweroff
    '';
    lidSwitch = "suspend-then-hibernate";
  };
  systemd.sleep.extraConfig = "HibernateDelaySec=600";

  # https://nixos.wiki/wiki/Swap
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024; # Size in mb -> 32 GiB (Should > RAM for hibernation)
    }
  ];
}
