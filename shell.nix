{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  NIX_CONFIG = "extra-experimental-features = nix-command flakes";

  packages = with pkgs; [
    nh
    python312Packages.mkdocs-material
    deploy-rs

    statix
    deadnix
    alejandra
    home-manager
    git
    sops
    ssh-to-age
    gnupg
    age
    zsh
  ];
}
