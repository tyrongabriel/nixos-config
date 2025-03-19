{
  inputs,
  lib,
  config,
  #outputs,
  ...
}:
{
  nix = {
    # Flakes and nix Command
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    # Nix path
    nixPath = [
      #"nix-config=~/nixos-config"
      "nix-config=/home/tyron/nixos-config"
      "nixpkgs=${inputs.nixpkgs}" # Recommended for nixd
    ];
  };

  # Checkable through systemd service
  # cat /etc/systemd/system/nixos-upgrade.service
  # And run execStart
  system.autoUpgrade = {
    enable = true;
    # path: is ESSENTIAL: Fixed git-repo ownership error when upgrading flake!
    flake = "path:${config.users.users.tyron.home}/nixos-config"; # "path:${outputs.flakePath}"; # inputs.self.outPath; # Points to flake in nix store, readonly lockfile!
    flags = [
      "--update-input"
      "nixpkgs"
      #"--commit-lock-file" # Doesnt work sadly
      "-L" # Logging
    ];
    dates = "daily";
    randomizedDelaySec = "45min";
  };

  # Auto garbage collect
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  # Automatic store-optimization
  nix.optimise = {
    automatic = true;
    dates = [ "daily" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # NH as an nixos-rebuild alternative
  # May be configured further in home-manager
  programs.nh = {
    enable = true;
    #clean.enable = true; # nix.gc already enabled
    #clean.extraArgs = "--keep-since 4d --keep 3";
    # Configured in home.nix homeDirectory
    flake = "${config.users.users.tyron.home}/nixos-config";
  };
  users.groups.uinput.gid = lib.mkForce 990; # To fix annoying warning not applying gid change of group...
}
