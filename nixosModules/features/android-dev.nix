{
  lib,
  config,
  pkgs-stable,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.myNixOS.android-dev;
in
{
  options.myNixOS.android-dev = with lib; {
    enable = mkEnableOption "Enable android dev environments";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      QT_QPA_PLATFORM = "xcb";
    };
    environment.systemPackages = with pkgs; [
      # Full Android Studio IDE (includes most of the SDK and AVD manager)
      # The 'android-studio-full' package includes a pre-composed SDK.
      android-studio-full

      # Dedicated RE tools (often have GUI versions available)
      jadx
      apktool

      # ADB is also part of the platform-tools which is in the full studio package,
      # but installing it directly ensures its presence and simplifies setup.
      # The 'android-tools' package provides 'adb', 'fastboot', etc.
      android-tools
    ];

    programs.adb.enable = true;

    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        # ovmf = { # not needed in NixOS 25.11 since https://github.com/NixOS/nixpkgs/pull/421549
        #   enable = true;
        #   packages = [(pkgs-stable.OVMF.override {
        #     secureBoot = true;
        #     tpmSupport = true;
        #   }).fd];
        # };
      };
    };

    users.users.${config.myNixOS.userName} = {
      extraGroups = [
        "adbusers"
        "kvm"
        "libvirtd"
      ]; # "kvm" is for better emulator performance
    };

  };
}
