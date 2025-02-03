{
  inputs,
  lib,
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

  system.autoUpgrade = {
    enable = true;
    flake = "/home/tyron/nixos-config";
    flags = [
      "--update-input"
      "nixpkgs"
    ];
    dates = "daily";
    randomizedDelaySec = "45min";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # NH as an nixos-rebuild alternative
  # May be configured further in home-manager
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    # Configured in home.nix homeDirectory
    flake = "/home/tyron/nixos-config";
  };
  users.groups.uinput.gid = lib.mkForce 990; # To fix annoying warning not applying gid change of group...
}
