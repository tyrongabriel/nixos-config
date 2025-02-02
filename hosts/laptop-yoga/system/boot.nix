{ pkgs, ... }:
{
  # Bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      # assuming /boot is the mount point of the  EFI partition in NixOS (as the installation section recommends).
      #efiSysMountPoint = "/boot/efi";
    };
    #   grub = {
    #     enable = false;
    #     device = "nodev"; # No specific partition
    #     useOSProber = true; # Autodetect windows
    #      efiSupport = true;
    #      gfxmodeEfi = "2880x1800x32";
    #gfxmodeEfi = "1920x1200x32";

    #      font = "${pkgs.fira-code}/share/fonts/truetype/FiraCode-VF.ttf";
    #      fontSize = 26;

    #      # Catppuccin Theme
    #      theme = (
    #        pkgs.catppuccin-grub.override {
    #          flavor = "mocha";
    #        }
    #      );
    #      splashImage = null;
    #      timeoutStyle = "hidden";
    #
    #};
    systemd-boot = {
      enable = true;
      consoleMode = "max";
    };
    grub.enable = false;
    # Hide os choice -> shows when pressing button
    timeout = 5;
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
      #logo = pkgs.fetchurl {
      #  url = "https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/logos/exports/1544x1544_circle.png";
      #  sha256 = "03ce7005d2764ad9203839b1b4d19f6cdabc3d4dc6de4aa7040c16bd05d5b6aa";
      #};
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
}
