{
  pkgs,
  ...
}:
{
  # Load the amdgpu kernel driver early in the boot process.
  # This is good practice for both X11 and Wayland.
  boot.initrd.kernelModules = [ "amdgpu" ];

  # Enable 3D acceleration with Mesa and its support for VA-API.
  # This is required for hardware video decoding.
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true; # Necessary for 32-bit applications
    extraPackages = with pkgs; [
      mesa.drivers
      mesa-va-drivers
      mesa-vdpau-drivers
      # For Vulkan support, which is often used by games and some apps.
      # The open-source RADV Vulkan driver is part of mesa.drivers
      vulkan-loader
    ];
  };

  # Set the environment variable to enable Wayland support for Brave/Chromium.
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    # You may also need to explicitly set this if NIXOS_OZONE_WL doesn't work.
    # This is less common on modern systems but worth knowing.
    # NIX_OZONE_PLATFORM = "wayland";
  };
}
