{
  pkgs,
  ...
}:
{
  # Load the amdgpu kernel driver early in the boot process.
  # This is good practice for both X11 and Wayland.
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];

  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;

  hardware.amdgpu = {
    initrd.enable = true;
    amdvlk.enable = true;
    opencl.enable = true;
  };

  # Enable 3D acceleration with Mesa and its support for VA-API.
  # This is required for hardware video decoding.
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      mesa
      #mesa-va-drivers
      #mesa-vdpau-drivers
      # For Vulkan support, which is often used by games and some apps.
      # The open-source RADV Vulkan driver is part of mesa.drivers
      vulkan-loader
      amdvlk

    ];
    # For 32 bit applications
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
  };

  hardware.opengl.driSupport32Bit = true; # Necessary for 32-bit applications

  # Set the environment variable to enable Wayland support for Brave/Chromium.
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    # You may also need to explicitly set this if NIXOS_OZONE_WL doesn't work.
    # This is less common on modern systems but worth knowing.
    # NIX_OZONE_PLATFORM = "wayland";
  };
  environment.systemPackages = with pkgs; [
    libva
    libva-utils
    radeontop
  ];
}
