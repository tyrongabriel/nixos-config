{ pkgs, lib, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  # Now handled by home-manager bundle
  users.users.tyron = lib.mkDefault {
    isNormalUser = true;
    description = "Tyron Gabriel";
    initialPassword = "12345";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];

    shell = pkgs.zsh; # Default shell
  };
  programs.zsh.enable = true;
}
