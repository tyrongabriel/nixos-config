{ pkgs, modulesPath, ... }:
{
  # https://github.com/vimjoyer/custom-installer-video
  # Build with nixos-generators:
  # nix run nixpkgs#nixos-generators -- --format iso --flake /path/to/flake#exampleIso -o result

  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  environment.systemPackages = with pkgs; [
    neovim
    git
    curl
    wget
    btop
    nh
    disko
    parted
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.git.userName = "tyrongabriel";
  programs.git.userEmail = "51530686+tyrongabriel@users.noreply.github.com";

}
