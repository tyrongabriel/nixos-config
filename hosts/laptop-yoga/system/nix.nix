{ inputs, ... }:
{
  nix = {
    # Flakes and nix Command
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    # Nix path
    nixPath = [
      "nix-config=~/nixos-config"
      "nixpkgs=${inputs.nixpkgs}"
    ];
  };

  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
    ];
    dates = "daily";
    randomizedDelaySec = "45min";
  };
}
