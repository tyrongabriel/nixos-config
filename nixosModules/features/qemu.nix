{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.qemu;
in
{
  options.myNixOS.qemu = with lib; {
    enable = mkEnableOption "Enable QEMU";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      qemu
      virt-manager
      virt-viewer
      spice
      spice-gtk
      spice-protocol
    ];

    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
          ovmf.enable = true;
          ovmf.packages = [ pkgs.OVMFFull.fd ];
        };
      };
      spiceUSBRedirection.enable = true;
    };
    services.spice-vdagentd.enable = true;
  };
}
