{ pkgs, ... }:
{
  # Bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      # assuming /boot is the mount point of the  EFI partition in NixOS (as the installation section recommends).
      #efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      device = "nodev"; # No specific partition
      useOSProber = true; # Autodetect windows
      efiSupport = true;
      gfxmodeEfi = "2880x1800x32";

      font = "${pkgs.fira-code}/share/fonts/truetype/FiraCode-VF.ttf";
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
        Logo=
      '';

    };

    # Enable silent booting
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
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
    ];
  };
  hardware.graphics.enable = true; # For plymouth to render instantly
}
