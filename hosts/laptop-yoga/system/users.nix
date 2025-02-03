{ pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tyron = {
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
