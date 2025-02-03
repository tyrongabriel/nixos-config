{ outputs, pkgs, ... }:
{
  imports = [ outputs.homeManagerModules.default ];
  # Configure Home
  home = {
    username = "tyron";
    homeDirectory = "/home/tyron";
    stateVersion = "24.11";
    sessionVariables = {
      #FLAKE = "${config.home.homeDirectory}/nixos-config"; # Not Working
      #FUCK = "HI";
    };
  };
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  # Some local git config
  programs.git.userName = "tyrongabriel";
  programs.git.userEmail = "51530686+tyrongabriel@users.noreply.github.com";

  # Configure myHome manager modules
  myHome = {
    bundles.general.enable = true;
  };

  # Extra packages not defined in myHome
  home.packages = with pkgs; [
    brave
    discord
    bitwarden
    nmap
  ];
}
