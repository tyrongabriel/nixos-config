{ config, pkgs, ... }:

{
  # 1. Ensure the cifs-utils package is available to handle the mount
  environment.systemPackages = [
    pkgs.cifs-utils
  ];

  # 2. Define the remote filesystem to be mounted
  fileSystems."/mnt/saarctf" = {
    # Replace "/mnt/share-name" with your desired mount path
    # Specify the device (the remote share path)
    device = "//ls.i/share";

    # Specify the filesystem type
    fsType = "cifs";

    # Specify the mount options
    options = [
      "x-systemd.automount" # Use systemd's automount to mount only on access
      "noauto" # Do not mount during the main boot process
      "credentials=/etc/nixos/cifs-secrets" # **Best Practice:** Use a separate secrets file
      "uid=1000" # Replace 1000 with the actual UID of the user (e.g., $(id -u))
      "gid=100" # Replace 100 with the actual GID of the user (e.g., $(id -g))
      "_netdev" # Specifies that the resource is network-dependent
    ];
  };
}
