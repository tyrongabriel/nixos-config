{
  pkgs,
  ...
}:
{
  # Load the amdgpu kernel driver early in the boot process.
  # This is good practice for both X11 and Wayland.
  boot.initrd.kernelModules = [
    "dm_mod"
    "amdgpu"
  ];
  boot.kernelModules = [
    "atkbd"
    "ctr"
    "loop"
    "kvm-amd"
    "radeon.si_support=0"
    "amdgpu.si_support=1"
    "radeon.cik_support=0"
    "amdgpu.cik_support=1"
  ];

  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;

  hardware.amdgpu = {
    initrd.enable = true;
    #amdvlk.enable = true;
    opencl.enable = true;
  };

  # Enable 3D acceleration with Mesa and its support for VA-API.
  # This is required for hardware video decoding.
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    package = pkgs.mesa;
    package32 = pkgs.mesa;
    extraPackages = with pkgs; [
      #mesa-va-drivers
      #mesa-vdpau-drivers
      # For Vulkan support, which is often used by games and some apps.
      # The open-source RADV Vulkan driver is part of mesa.drivers
      vulkan-loader
      #amdvlk
      #

    ];
  };

  #hardware.opengl.driSupport32Bit = true; # Necessary for 32-bit applications

  # Set the environment variable to enable Wayland support for Brave/Chromium.
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    LIBVA_DRIVER_NAME = "radeonsi"; # <-- Add this line
    DRI_PRIME = "0"; # <-- Add this line (especially useful for hybrid graphics)

    # You may also need to explicitly set this if NIXOS_OZONE_WL doesn't work.
    # This is less common on modern systems but worth knowing.
    # NIX_OZONE_PLATFORM = "wayland";
  };

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.systemPackages = with pkgs; [
    libva
    libva-vdpau-driver
    libvdpau-va-gl
    libva-utils
    radeontop
    egl-wayland
    libGL
    clinfo
  ];
  # export OZONE_PLATFORM=wayland
  # export EGL_PLATFORM=wayland
  # brave --enable-gpu-rasterization --enable-zero-copy --ignore-gpu-blocklist --enable-features=VaapiVideoDecoder,VaapiVideoEncoder,WaylandWindowDecorations

}
